RSpec.describe JeniaBot::Op::Message::Sync do
  let(:chat) { Fabricate(:jenia_bot_chat) }

  context 'when params is not valid' do
    let(:params) { { id: '123', chat_id: '456', created_at: nil, updated_at: nil } }
    let(:result) { described_class.call(chat: chat, params: params) } 

    it { expect(result.failure?).to be_truthy }

    it 'contains failed validation result' do
      expect(result[:validation_result].errors.to_h).to include(
        :id, :created_at, :updated_at
      )
    end

    it 'contains error message' do
      expect(result[:error]).to include('Validation error:')
    end
  end

  context 'when params is valid' do
    let(:result) { described_class.call(chat: chat, params: params) } 
    
    context 'when message exists' do
      let(:message) { Fabricate(:jenia_bot_message) }
      let(:params) do 
        { 
          message_id: message.id,
          chat_id: message.chat_id,
          date: Time.now
        }
      end  

      it 'returns message' do
        expect(result[:message]).to eq(message)
      end
    end
    
    context 'when message does not exist' do
      let(:params) do 
        { 
          message_id: 999,
          date: Time.now.to_i
        }
      end
      
      it 'creates and returns message' do
        expect(result[:message].id).to eq(params[:message_id])
        expect(result[:message].chat_id).to eq(chat.id)
        expect(result[:message].created_at).to eq(Time.at(params[:date]))
      end
    end

  end
end
