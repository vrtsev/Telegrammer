# frozen_string_literal: true

RSpec.describe JeniaBot::Controller, type: :controller, telegram_bot: :poller do
  let(:bot) { Telegram.bots[:jenia_bot] }

  describe '#message' do
    subject { -> { dispatch_message(payload['text'], payload) }.call }

    context 'when payload does not contain text' do
      let(:payload_text) { nil }

      it { is_expected.to be_nil }
    end

    context 'when payload contains text' do
      let(:payload_text) { 'Payload text' }
      let(:response) { 'Response text' }
      let(:auto_response_result) { instance_double(AutoResponses::Random, response: response) }

      before { allow(AutoResponses::Random).to receive(:call).and_return(auto_response_result) }

      it 'calls AutoResponses::Random service' do
        expect(AutoResponses::Random).to receive(:call)
          .with({ chat_id: current_chat.id, message_text: payload['text'], bot: :jenia_bot })
          .once

        subject
      end

      it 'calls JeniaBot::Responders::AutoResponse responder' do
        expect_response(JeniaBot::Responders::AutoResponse, response: response)
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

    it 'calls JeniaBot::Responders::StartMessage responder' do
      expect_response(JeniaBot::Responders::StartMessage, bot_author: app_owner_user.username)
      subject
    end
  end

  describe '#jenia!' do
    subject { -> { dispatch_command(:jenia, payload.to_h) }.call }

    let(:payload_text) { '/jenia' }
    let(:auto_response_result) { instance_double(AutoResponses::Random, success?: true, response: response) }
    let(:questions_list_result) { instance_double(JeniaQuestions::GetList, success?: true, questions: questions) }
    let(:response) { 'Response text' }
    let(:questions) { ['First question', 'Second question'] }

    before do
      allow(AutoResponses::Random).to receive(:call).and_return(auto_response_result)
      allow(JeniaQuestions::GetList).to receive(:call).and_return(questions_list_result)
    end

    it 'calls AutoResponses::Random service' do
      expect(AutoResponses::Random).to receive(:call)
        .with({ chat_id: current_chat.id, message_text: payload['text'], bot: :jenia_bot })
        .once

      subject
    end

    it 'calls JeniaQuestions::GetList service' do
      expect(JeniaQuestions::GetList).to receive(:call)
        .with({ chat_id: current_chat.id })
        .once

      subject
    end

    it 'calls JeniaBot::Responders::CallJenia responder' do
      expect_response(JeniaBot::Responders::CallJenia, response: response, questions: questions)
      subject
    end
  end
end
