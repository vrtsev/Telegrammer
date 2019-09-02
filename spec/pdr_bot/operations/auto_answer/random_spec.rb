RSpec.describe PdrBot::Op::AutoAnswer::Random do
  let(:current_chat) { Fabricate(:pdr_bot_chat) }
  let(:auto_answers) { Fabricate.times(4, :pdr_bot_auto_answer, chat_id: current_chat.id) }
  let(:message)      { Fabricate(:pdr_bot_message, chat_id: current_chat.id, text: auto_answers.sample.trigger) } 

  let(:other_chat)   { Fabricate(:pdr_bot_chat) }
  let(:other_auto_answers) { Fabricate.times(4, :pdr_bot_auto_answer, chat_id: other_chat.id) }

  it 'should not return auto answer of another chat' do
    result = described_class.call(chat: current_chat, message: message)
    expect(other_chat.id).not_to eq(result[:auto_answer].chat_id)
  end

  context 'when answer found' do
    it 'returns answer by trigger message' do
      result = described_class.call(chat: current_chat, message: message)
      expect(current_chat.id).to eq(result[:auto_answer].chat_id)
      expect(auto_answers.map(&:answer)).to include(result[:answer])
    end
  end

  context 'when answer not found' do
    let(:message) { Fabricate(:pdr_bot_message, text: 'some random message 123') }

    it 'returns nil answer' do
      result = described_class.call(chat: current_chat, message: message)
      expect(auto_answers.map(&:answer)).not_to include(result[:answer])
    end
  end
end
