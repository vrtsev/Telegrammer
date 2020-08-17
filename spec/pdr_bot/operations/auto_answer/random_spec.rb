# frozen_string_literal: false

RSpec.describe PdrBot::Op::AutoAnswer::Random do
  let(:current_chat) { Fabricate(:pdr_bot_chat) }
  let(:auto_answers) { Fabricate.times(4, :pdr_bot_auto_answer, chat_id: current_chat.id) }
  let(:message)      { Fabricate(:pdr_bot_message, chat_id: current_chat.id, text: auto_answers.sample.trigger + ' some message') }

  let(:other_chat)   { Fabricate(:pdr_bot_chat) }
  let(:other_auto_answers) { Fabricate.times(4, :pdr_bot_auto_answer, chat_id: other_chat.id) }

  let(:params) { { chat_id: current_chat.id, message_text: message.text } }
  let(:result) { described_class.call(params: params) }

  it 'should not return auto answer of another chat' do
    expect(result[:auto_answer].chat_id).not_to eq(other_chat.id)
  end

  context 'when answer found' do
    it 'returns answer by trigger message' do
      expect(result[:auto_answer].chat_id).to eq(current_chat.id)
      expect(auto_answers.map(&:answer)).to include(result[:answer])
    end
  end

  context 'when answer not found' do
    let(:message) { Fabricate(:pdr_bot_message, text: 'some random message 123') }

    it 'returns nil answer' do
      expect(auto_answers.map(&:answer)).not_to include(result[:answer])
    end
  end
end
