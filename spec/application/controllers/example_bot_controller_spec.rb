# frozen_string_literal: true

RSpec.describe ExampleBot::Controller, type: :controller, telegram_bot: :poller do
  let(:bot) { Telegram.bots[:example_bot] }

  describe '#message' do
    subject { -> { dispatch_message(payload_text, payload) }.call }

    context 'when payload does not contain text' do
      let(:payload_text) { nil }

      it { is_expected.to be_nil }
    end

    context 'when payload contains text' do
      let(:payload_text) { 'Payload text' }
      let(:response) { 'Response text' }
      let(:result) { instance_double(AutoResponses::Random, success?: true, response: response) }

      before { allow(AutoResponses::Random).to receive(:call).and_return(result) }

      it 'calls AutoResponses::Random service' do
        expect(AutoResponses::Random).to receive(:call).once
        subject
      end

      it 'calls ExampleBot::Responders::AutoResponse responder' do
        expect_response(ExampleBot::Responders::AutoResponse, response: response)
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

    it 'calls ExampleBot::Responders::StartMessage responder' do
      expect_response(ExampleBot::Responders::StartMessage, bot_author: app_owner_user.username)
      subject
    end
  end
end
