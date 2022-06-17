# frozen_string_literal: true

RSpec.describe JeniaBot::Controller, type: :controller, telegram_bot: :poller do
  include_examples 'helpers/logging_examples'
  include_examples 'helpers/translation_examples'
  include_examples 'controller/message_helpers_examples'
  include_examples 'controller/bot_state_examples'
  include_examples 'controller/sync_examples'
  include_examples 'controller/events_examples'
  include_examples 'controller/authorization_examples'

  let(:bot_name) { :jenia_bot }

  describe '#message' do
    subject { -> { dispatch_message(payload_text, base_payload) }.call }

    context 'when current message does not contain text' do
      let(:payload_text) { nil }

      it { is_expected.to be_nil }
    end

    context 'when current message contains text' do
      let(:payload_text) { Faker::Lorem.sentence }

      before { allow_service_call(AutoResponses::Random).and_return(auto_response_result) }

      context 'and response is blank' do
        let(:auto_response_result) { instance_double(AutoResponses::Random, response: nil) }

        it { is_expected.to be_nil }
      end

      context 'and response is present' do
        let(:auto_response_result) { instance_double(AutoResponses::Random, response: 'Response') }

        it { expect_service_call(AutoResponses::Random, chat_id: current_chat.id, message_text: current_message.text, bot_id: bot.id) }
        it { expect_reply_message(text: 'Response', delay: stubbed_delay) }
      end
    end
  end

  describe '#start!' do
    subject { -> { dispatch_command(:start, base_payload) }.call }

    it { expect_sent_message(text: stubbed_text) }
  end

  describe '#jenia!' do
    subject { -> { dispatch_command(:jenia, base_payload) }.call }

    let(:questions_list_result) { instance_double(JeniaQuestions::GetList, success?: true, questions: ['First question', 'Second question']) }
    let(:auto_response_result) { instance_double(AutoResponses::Random, success?: true, response: 'Response text') }

    before do
      allow_service_call(JeniaQuestions::GetList).and_return(questions_list_result)
      allow_service_call(AutoResponses::Random).and_return(auto_response_result)
    end

    it { expect_service_call(JeniaQuestions::GetList, chat_id: current_chat.id) }
    it { expect_service_call(AutoResponses::Random, chat_id: current_chat.id, message_text: current_message.text, bot_id: bot.id) }

    it 'replies to user message' do
      expect_reply_message(
        text: 'Response text',
        reply_markup: {
          keyboard: [['First question'], ['Second question']],
          one_time_keyboard: true,
          resize_keyboard: true
        }
      )
    end
  end

  describe '#handle_exception' do
    subject { described_class.new(bot, base_payload).send(:handle_exception, exception) }

    let(:exception) { RuntimeError.new }
    let(:template_data) { Hash[text: 'Template text', chat_id: 1] }

    before do
      allow_any_instance_of(described_class).to receive(:payload).and_return(base_payload)
      allow(BotBase::Templates::ExceptionReport).to receive(:build)
        .with(exception: exception, payload: base_payload)
        .and_return(template_data)
    end

    it { expect_sent_message(template_data) }
  end
end
