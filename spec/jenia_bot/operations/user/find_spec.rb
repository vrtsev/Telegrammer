RSpec.describe JeniaBot::Op::User::Find do
  context 'when params is not valid' do
    let(:params) { { user_id: 'string' } }
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
    let(:result) { described_class.call(params: params) }

    describe 'user' do
      context 'when exists' do
        let(:user)   { Fabricate(:jenia_bot_user) }
        let(:params) { { user_id: user.id } }

        it { expect(result[:user]).to eq(user) }
      end

      context 'when does not exist' do
        let(:params) { { chat_id: chat.id, id: 999, username: 'sample uname' } }

        it { expect(result.success?).to be_falsey }
      end
    end
  end
end
