# frozen_string_literal: true

RSpec.describe AutoResponses::Random do
  subject { described_class.call(params) }

  let(:params) { Hash[chat_id: chat.id, message_text: trigger, bot_id: bot.id] }
  let(:bot) { create(:bot, name: 'example_bot', username: 'example_bot') }
  let(:trigger) { 'Some message text' }
  let(:chat) { create(:chat) }

  context 'and when trigger response does not exist' do
    it { expect(subject.response).to be_nil }
  end

  context 'and when trigger response exists' do
    let(:response) { 'Trigger response text' }

    before { create(:auto_response, chat: chat, trigger: trigger, response: response, bot: bot) }

    it { expect(subject.response).to eq(response) }

    context 'when message contains forbidden characters' do
      let(:params) { Hash[chat_id: chat.id, message_text: trigger_with_forbidden_symbols, bot_id: bot.id] }
      let(:trigger_with_forbidden_symbols) { 'Some message text' + described_class::FORBIDDEN_SYMBOLS }

      context 'when sanitized_message_text is blank' do
        let(:trigger_with_forbidden_symbols) { described_class::FORBIDDEN_SYMBOLS }

        it { expect(subject.response).to be_nil }
      end

      it { expect(subject.response).to eq(response) }
    end
  end
end
