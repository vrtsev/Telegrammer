# frozen_string_literal: true

RSpec.describe PdrBot::Controller, type: :controller, telegram_bot: :poller do
  include_examples 'helpers/logging_examples'
  include_examples 'helpers/translation_examples'
  include_examples 'controller/message_helpers_examples'
  include_examples 'controller/bot_state_examples'
  include_examples 'controller/sync_examples'
  include_examples 'controller/events_examples'
  include_examples 'controller/authorization_examples'

  let(:bot_name) { :pdr_bot }

  describe '#message' do
    subject { -> { dispatch_message(payload_text, base_payload) }.call }

    let(:payload_text) { Faker::Lorem.sentence }

    context 'when current message does not have text' do
      let(:payload_text) { nil }

      it { is_expected.to be_nil }
    end

    context 'when current message has text' do
      let(:service_result) { instance_double(AutoResponses::Random, response: response) }
      let(:response) { nil }

      before { allow_service_call(AutoResponses::Random).and_return(service_result) }

      it { expect_service_call(AutoResponses::Random, chat_id: current_chat.id, message_text: current_message.text, bot_id: bot.id) }

      context 'when response of service result is blank' do
        it { is_expected.to be_nil }
      end

      context 'when response of service result is present' do
        let(:response) { 'Response text' }

        it { expect_reply_message(text: response, delay: stubbed_delay) }
      end
    end
  end

  describe '#start!' do
    subject { -> { dispatch_command(:start, base_payload) }.call }

    it { expect_sent_message(text: stubbed_text) }
  end

  describe '#pdr!' do
    subject { -> { dispatch_command(:pdr, base_payload) }.call }

    before { allow_service_call(PdrGame::Run).and_return(service_result) }

    include_examples 'failed service', PdrGame::Run

    context 'when service is success' do
      let(:service_result) { instance_double(PdrGame::Run, success?: true) }

      before { allow_any_instance_of(described_class).to receive(:results!) }

      it { expect_service_call(PdrGame::Run, chat_id: current_chat.id, initiator_id: current_user.id) }
      it { message_expectation(:send_message, text: stubbed_text, delay_after: stubbed_delay).twice; subject }
      it { expect_any_instance_of(described_class).to receive(:results!).once; subject }
    end
  end

  describe '#results!' do
    subject { -> { dispatch_command(:results, base_payload) }.call }

    before { allow_service_call(PdrGame::Rounds::LatestResults).and_return(service_result) }

    include_examples 'failed service', PdrGame::Rounds::LatestResults

    context 'when service is success' do
      let(:winner) { create(:user) }
      let(:loser) { create(:user) }
      let(:service_result) { instance_double(PdrGame::Rounds::LatestResults, success?: true, winner: winner, loser: loser) }
      let(:game_results_template_data) { Hash[text: 'Game results'] }

      before do
        allow(PdrBot::Templates::Game::Results).to receive(:build)
          .with(current_chat_id: current_chat.id, winner_name: winner.name, loser_name: loser.name)
          .and_return(game_results_template_data)
      end

      it { expect_service_call(PdrGame::Rounds::LatestResults, chat_id: current_chat.id) }
      it { expect_sent_message(game_results_template_data) }
    end
  end

  describe '#stats!' do
    subject { -> { dispatch_command(:stats, base_payload) }.call }

    before { allow_service_call(PdrGame::Stats::ByChat).and_return(service_result) }

    include_examples 'failed service', PdrGame::Stats::ByChat

    context 'when service is success' do
      let(:game_stats_message_data) { Hash[text: 'Game stats'] }
      let(:service_result) do
        instance_double(PdrGame::Stats::ByChat,
                        success?: true,
                        winner_leader_stat: create(:pdr_game_stat),
                        loser_leader_stat: create(:pdr_game_stat),
                        chat_stats: [create_list(:pdr_game_stat, 2)])
      end

      before do
        allow(PdrBot::Templates::Game::Stats).to receive(:build)
          .with(
            current_chat_id: current_chat.id,
            winner_leader_stat: service_result.winner_leader_stat,
            loser_leader_stat: service_result.loser_leader_stat,
            chat_stats: service_result.chat_stats
          ).and_return(game_stats_message_data)
      end

      it { expect_service_call(PdrGame::Stats::ByChat, chat_id: current_chat.id) }
      it { expect_sent_message(game_stats_message_data) }
    end
  end

  describe '#reset_stats!' do
    subject { -> { dispatch_command(:reset_stats, base_payload) }.call }

    before do
      allow_service_call(PdrGame::Stats::Reset).and_return(service_result)
      allow_any_instance_of(described_class).to receive(:authorize_admin).and_return(true)
    end

    include_examples 'failed service', PdrGame::Stats::Reset

    context 'when service is success' do
      let(:service_result) { instance_double(PdrGame::Stats::Reset, success?: true) }

      it { expect_service_call(PdrGame::Stats::Reset, chat_id: current_chat.id) }
    end
  end

  describe '#respond_with_error' do
    subject { described_class.new(bot, base_payload).send(:respond_with_error, exception) }

    let(:exception) { ::BaseService::ServiceError.new(error_code: 'ERROR') }
    let(:template_data) { Hash[text: 'Template text'] }

    before do
      allow_any_instance_of(described_class).to receive(:payload).and_return(base_payload)
      allow_any_instance_of(described_class).to receive(:current_chat).and_return(current_chat)
      allow(PdrBot::Templates::ServiceError).to receive(:build)
        .with(current_chat_id: current_chat.id, error_code: exception.error_code)
        .and_return(template_data)
    end

    it { expect_sent_message(template_data) }
  end

  describe '#handle_exception' do
    subject { described_class.new(bot, base_payload).send(:handle_exception, exception) }

    let(:exception) { RuntimeError.new }
    let(:template_data) { Hash[text: 'Template text', chat_id: 1] }

    before do
      allow_any_instance_of(described_class).to receive(:payload).and_return(base_payload)
      allow_any_instance_of(described_class).to receive(:action_type).and_return(:command)
      allow(BotBase::Templates::ExceptionReport).to receive(:build)
        .with(exception: exception, payload: base_payload)
        .and_return(template_data)
    end

    context 'when action_type is command' do
      it 'sends messages' do
        message_expectation(:send_message, template_data)
        message_expectation(:send_message, text: stubbed_text)

        subject
      end
    end

    context 'when action_type is not command' do
      before { allow_any_instance_of(described_class).to receive(:action_type).and_return(:message) }

      it { is_expected.to be_nil }
      it { expect_sent_message(template_data) }
    end
  end
end
