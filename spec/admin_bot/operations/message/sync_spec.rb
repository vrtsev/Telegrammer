RSpec.describe AdminBot::Op::Message::Sync do
  context 'when params is not valid' do
    let(:params) { { id: '123', created_at: nil, updated_at: nil } }
    let(:result) { described_class.call(params: params) } 

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
    let(:result) { described_class.call(params: params) } 
    
    context 'when message exists' do
      let(:message) { Fabricate(:admin_bot_message) }
      let(:params) do 
        { 
          message_id: message.id,
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
        expect(result[:message].created_at).to eq(Time.at(params[:date]))
      end
    end

  end
end
