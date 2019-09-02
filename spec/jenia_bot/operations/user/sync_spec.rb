RSpec.describe JeniaBot::Op::User::Sync do

  context 'when params is not valid' do
    let(:params) { { id: 'string' } }
    let(:result) { described_class.call(params: params) }

    it { expect(result.failure?).to be_truthy }

    it 'contains failed validation result' do
      expect(result[:validation_result].errors.to_h).to include(*params.keys)
    end

    it 'contains error message' do
      expect(result[:error]).to include('Validation error:')
    end
  end

  context 'when params is valid' do
    let(:chat) { Fabricate(:jenia_bot_chat) }
    let(:result) { described_class.call(chat: chat, params: params) }

    describe 'user' do

      context 'when exists' do
        let(:user)   { Fabricate(:jenia_bot_user) }
        let(:params) { { id: user.id } }

        it { expect(result[:user]).to eq(user) }
      end

      context 'when does not exist' do
        let(:params) { { id: 999, username: 'sample uname' } }

        it 'creates and returns chat' do
          expect(result[:user].id).to eq(params[:id])
          expect(result[:user].username).to eq(params[:username])
        end
      end
    end

    describe 'chat user' do
      let(:params) { { id: user.id } }

      context 'when exists' do
        let(:user) { Fabricate(:jenia_bot_user) }
        let(:chat) { Fabricate(:jenia_bot_chat) }
        let!(:chat_user) { Fabricate(:jenia_bot_chat_user, chat_id: chat.id, user_id: user.id) }

        it { expect(result[:chat_user]).to eq(chat_user) }
      end

      context 'when does not exist' do
        let(:user) { Fabricate(:jenia_bot_user) }
        let(:chat) { Fabricate(:jenia_bot_chat) }

        it 'creates and returns chat user' do
          expect(result[:chat_user].user_id).to eq(user.id)
          expect(result[:chat_user].chat_id).to eq(chat.id)
        end
      end
    end

  end
end
