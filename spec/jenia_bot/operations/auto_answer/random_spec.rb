RSpec.describe JeniaBot::Op::AutoAnswer::Random do
  let(:chat)         { Fabricate(:jenia_bot_chat) }
  let(:auto_answers) { Fabricate.times(4, :jenia_bot_auto_answer, chat_id: chat.id) }
  let(:message)      { Fabricate(:jenia_bot_message, text: auto_answers.sample.trigger) }
  let(:params)       { { chat_id: chat.id, message_text: message.text } }

  context 'when answer found' do
    it 'returns answer by trigger message' do
      result = described_class.call(params: params)
      expect(auto_answers.map(&:answer)).to include(result[:answer])
    end
  end

  context 'when answer not found' do
    let(:message) { Fabricate(:jenia_bot_message, text: 'some random message 123') }

    it 'returns nil answer' do
      result = described_class.call(params: params)
      expect(auto_answers.map(&:answer)).not_to include(result[:answer])
    end
  end
end
