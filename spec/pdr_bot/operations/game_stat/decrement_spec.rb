RSpec.describe PdrBot::Op::GameStat::Decrement do

  context 'when params are invalid' do
    let(:params) { { chat_id: 'string', user_id: 'lala', counter_type: 111 } }
    let(:result) { described_class.call(params: params) } 

    it { expect(result.failure?).to be_truthy }

    it 'contains failed validation result' do
      expect(result[:validation_result].errors.to_h.keys).to include(:chat_id, :user_id, :counter_type)
    end

    it 'contains error message' do
      expect(result[:error]).to include('Validation error:')
    end
  end

  context 'when params are valid' do
    let(:user) { Fabricate(:pdr_bot_user) }
    let(:chat) { Fabricate(:pdr_bot_chat) }
    let(:chat_user) { Fabricate(:pdr_bot_chat_user, chat_id: chat.id, user_id: user.id) }
    let(:params) { { chat_id: chat_user.chat_id, user_id: chat_user.user_id, counter_type: PdrBot::GameStat::Counters.winner } }
    let(:result) { described_class.call(params: params) }

    let!(:game_stat) do
      Fabricate(
        :pdr_bot_game_stat,
        user_id: chat_user.user_id,
        chat_id: chat_user.chat_id,
        loser_count: 1,
        winner_count: 1
      )
    end

    describe 'counter' do
      it 'finds chat user' do
        expect(result[:chat_user].id).to eq(chat_user.id)
      end

      context 'when winner' do
        it 'decrements loser counter on chat user stat' do
          expect(result[:game_stat].reload.winner_count).to eq(0)
          expect(result[:game_stat].reload.loser_count).to eq(1)
        end
      end

      context 'when loser' do
        let(:params) { { chat_id: chat_user.chat_id, user_id: chat_user.user_id, counter_type: PdrBot::GameStat::Counters.loser } }

        it 'decrements winner counter on chat user stat' do
          expect(result[:game_stat].reload.loser_count).to eq(0)
          expect(result[:game_stat].reload.winner_count).to eq(1)
        end
      end
    end
  end
end
