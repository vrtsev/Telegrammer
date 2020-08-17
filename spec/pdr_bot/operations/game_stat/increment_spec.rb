# frozen_string_literal: false

RSpec.describe PdrBot::Op::GameStat::Increment do
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

    context 'when stat does not exist' do
      it 'creates new user stat for chat' do
        expect(result[:stat].chat_id).to eq(chat.id)
        expect(result[:stat].user_id).to eq(user.id)
      end

      describe 'counter' do
        context 'when winner' do
          it 'increments loser counter on chat user stat' do
            stat = result[:stat].reload
            expect(stat.winner_count).to eq(1)
            expect(stat.loser_count).to eq(0)
          end
        end

        context 'when loser' do
          let(:params) { { chat_id: chat_user.chat_id, user_id: chat_user.user_id, counter_type: PdrBot::GameStat::Counters.loser } }

          it 'increments winner counter on chat user stat' do
            stat = result[:stat].reload
            expect(stat.loser_count).to eq(1)
            expect(stat.winner_count).to eq(0)
          end
        end
      end
    end

    context 'when stat exists' do
      let!(:stat) { Fabricate(:pdr_bot_game_stat, user_id: chat_user.user_id, chat_id: chat_user.chat_id) }

      describe 'counter' do
        context 'when winner' do
          it 'increments loser counter on chat user stat' do
            stat = result[:stat].reload
            expect(stat.winner_count).to eq(1)
            expect(stat.loser_count).to eq(0)
          end
        end

        context 'when loser' do
          let(:params) { { chat_id: chat_user.chat_id, user_id: chat_user.user_id, counter_type: PdrBot::GameStat::Counters.loser } }

          it 'increments winner counter on chat user stat' do
            stat = result[:stat].reload
            expect(stat.loser_count).to eq(1)
            expect(stat.winner_count).to eq(0)
          end
        end
      end
    end
  end
end
