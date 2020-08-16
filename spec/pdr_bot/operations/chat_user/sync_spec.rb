RSpec.describe PdrBot::Op::ChatUser::Sync do

  context 'when params is not valid' do
    let(:params) { { chat_id: 'string', user_id: 'string' } }
    let(:result) { described_class.call(params: params) }

    it { expect(result.failure?).to be_truthy }

    it 'contains failed validation result' do
      expect(result[:validation_result].errors.to_h).to include(:chat_id, :user_id)
    end

    it 'contains error message' do
      expect(result[:error]).to include('Validation error:')
    end
  end

  context 'when params is valid' do
    let(:result) { described_class.call(params: params) }

    context 'when chat user exists' do
      let(:chat_user) { Fabricate(:pdr_bot_chat_user) }
      let(:params) { { chat_id: chat_user.chat_id, user_id: chat_user.user_id } }

      it 'returns chat' do
        expect(result[:chat_user]).to eq(chat_user)
      end
    end

    context 'chat user does not exist' do
      let(:chat) { Fabricate(:pdr_bot_chat) }
      let(:user) { Fabricate(:pdr_bot_user) }
      let(:params) { { chat_id: chat.id, user_id: user.id } }

      it 'creates and returns chat' do
        expect(result[:chat_user].chat_id).to eq(params[:chat_id])
        expect(result[:chat_user].user_id).to eq(params[:user_id])
      end
    end
  end
end
