# frozen_string_literal: false

RSpec.describe ExampleBot::Op::User::Sync do
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
    let(:chat) { Fabricate(:example_bot_chat) }
    let(:result) { described_class.call(params: params) }

    describe 'user' do
      context 'when exists' do
        let(:user)   { Fabricate(:example_bot_user) }
        let(:params) do
          {
            chat_id: chat.id,
            id: user.id,
            first_name: user.first_name,
            last_name: user.last_name,
            username: user.username
          }
        end

        it { expect(result[:user]).to eq(user) }
      end

      context 'when does not exist' do
        let(:params) { { chat_id: chat.id, id: 999, username: 'sample uname' } }

        it 'creates and returns chat' do
          expect(result[:user].id).to eq(params[:id])
          expect(result[:user].username).to eq(params[:username])
        end
      end
    end
  end
end
