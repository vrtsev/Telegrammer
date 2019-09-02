RSpec.describe ExampleBot::Op::AutoAnswer::Random do
  let(:chat)         { Fabricate(:example_bot_chat) }
  let(:auto_answers) { Fabricate.times(4, :example_bot_auto_answer, chat_id: chat.id) }
  let(:message)      { Fabricate(:example_bot_message, text: auto_answers.sample.trigger) }

  context 'when answer found' do
    it 'returns answer by trigger message' do
      result = described_class.call(chat: chat, message: message)
      expect(auto_answers.map(&:answer)).to include(result[:answer])
    end
  end

  context 'when answer not found' do
    let(:message) { Fabricate(:example_bot_message, text: 'some random message 123') }

    it 'returns nil answer' do
      result = described_class.call(chat: chat, message: message)
      expect(auto_answers.map(&:answer)).not_to include(result[:answer])
    end
  end
end
