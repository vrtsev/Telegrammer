# frozen_string_literal: true

RSpec.describe PdrBot::Controller, type: :controller, telegram_bot: :poller do
  let(:bot) { Telegram.bots[:pdr_bot] }

  describe '#message' do
    subject { -> { dispatch_message(payload['text'], payload) }.call }

    context 'when payload does not contain text' do
      let(:payload_text) { nil }

      it { is_expected.to be_nil }
    end

    context 'when payload contains text' do
      before { allow(AutoResponses::Random).to receive(:call).and_return(trigger_response_result) }

      let(:payload_text) { 'Payload text' }
      let(:response) { 'Response text' }
      let(:trigger_response_result) { instance_double(AutoResponses::Random, response: response) }

      it 'calls AutoResponses::Random service' do
        expect(AutoResponses::Random).to receive(:call)
          .with({ chat_id: current_chat.id, message_text: payload['text'], bot: :pdr_bot })
          .once

        subject
      end

      it 'calls PdrBot::Responders::AutoResponse responder' do
        expect_response(PdrBot::Responders::AutoResponse, response: response)
        subject
      end
    end
  end

  describe '#start!' do
    subject { -> { dispatch_command(:start, payload.to_h) }.call }

    let(:payload_text) { '/start' }
    let(:telegram_app_owner_id) { 123456 }
    let!(:app_owner_user) { create(:user, external_id: telegram_app_owner_id) }

    before { stub_env('TELEGRAM_APP_OWNER_ID', telegram_app_owner_id.to_s) }

    it 'calls PdrBot::Responders::StartMessage responder' do
      expect_response(PdrBot::Responders::StartMessage, bot_author: app_owner_user.username)
      subject
    end
  end

  describe '#pdr!' do
    subject { -> { dispatch_command(:pdr, payload.to_h) }.call }
    let(:payload_text) { '/pdr' }

    context 'when pdr game service is success' do
      let(:result) { instance_double(PdrGame::Run, success?: true) }

      before { allow(PdrGame::Run).to receive(:call).and_return(result) }

      it 'calls PdrGame::Run service' do
        expect(PdrGame::Run).to receive(:call).with({ chat_id: current_chat.id, initiator_id: current_user.id })
        subject
      end

      it 'calls PdrBot::Responders::Game::Start responder' do
        expect_response(PdrBot::Responders::Game::Start)
        subject
      end

      it 'calls results action' do
        expect_any_instance_of(described_class).to receive(:results!)
        subject
      end
    end
  end

  describe '#results!' do
    subject { -> { dispatch_command(:results, payload.to_h) }.call }
    let(:payload_text) { '/results' }

    context 'when pdr game latest results service is success' do
      let(:winner) { create(:user) }
      let(:loser) { create(:user) }
      let(:result) { instance_double(PdrGame::Rounds::LatestResults, success?: true, winner: winner, loser: loser) }

      before { allow(PdrGame::Rounds::LatestResults).to receive(:call).and_return(result) }

      it 'calls PdrGame::Rounds::LatestResults service' do
        expect(PdrGame::Rounds::LatestResults).to receive(:call).with({ chat_id: current_chat.id })
        subject
      end

      it 'calls PdrBot::Responders::Game::Results responder' do
        expect_response(PdrBot::Responders::Game::Results, winner_name: winner.name, loser_name: loser.name)
        subject
      end
    end
  end

  describe '#stats!' do
    subject { -> { dispatch_command(:stats, payload.to_h) }.call }

    let(:payload_text) { '/stats' }

    context 'when pdr game stats service is success' do
      let(:chat_stat) { create(:pdr_game_stat) }
      let(:winner_leader_stat) { create(:pdr_game_stat) }
      let(:loser_leader_stat) { create(:pdr_game_stat) }
      let(:result) do
        instance_double(PdrGame::Stats::ByChat,
                        success?: true,
                        winner_leader_stat: winner_leader_stat,
                        loser_leader_stat: loser_leader_stat,
                        chat_stats: [chat_stat])
      end

      before { allow(PdrGame::Stats::ByChat).to receive(:call).and_return(result) }

      it 'calls PdrGame::Stats::ByChat service' do
        expect(PdrGame::Stats::ByChat).to receive(:call).with({ chat_id: current_chat.id })
        subject
      end

      it 'calls PdrBot::Responders::Game::Stats responder' do
        expect_response(PdrBot::Responders::Game::Stats,
                        winner_leader_stat: winner_leader_stat,
                        loser_leader_stat: loser_leader_stat,
                        chat_stats: [chat_stat])
        subject
      end
    end
  end
end
