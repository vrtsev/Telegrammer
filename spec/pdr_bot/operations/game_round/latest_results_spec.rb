RSpec.describe PdrBot::Op::GameRound::LatestResults do
  let(:current_user) { Fabricate(:pdr_bot_user) }
  let(:current_chat) { Fabricate(:pdr_bot_chat) }

  describe 'last game round' do
    context 'when does not exist' do
      let(:params) { { chat_id: current_chat.id } }
      let(:result) { described_class.call(params: params) }

      it { expect(result.failure?).to be_truthy }
      it { expect(result[:error].present?).to be_truthy }
      it { expect(I18n.t('.pdr_bot.latest_results.results_not_found')).to include(result[:error]) }
    end

    context 'when present' do
      let!(:loser) { Fabricate(:pdr_bot_user) } 
      let!(:winner) { Fabricate(:pdr_bot_user) } 
      let(:loser_chat_user) { Fabricate(:pdr_bot_chat_user, user_id: loser.id, chat_id: current_chat.id) }
      let(:winner_chat_user) { Fabricate(:pdr_bot_chat_user, user_id: winner.id, chat_id: current_chat.id) }
      let!(:latest_game_round) do
        Fabricate(:pdr_bot_game_round,
          chat_id: current_chat.id,
          loser_id: loser.id,
          winner_id: winner.id,
          created_at: Time.now
        )
      end
      let!(:old_game_round) do
        Fabricate(:pdr_bot_game_round,
          chat_id: current_chat.id, 
          created_at: (Date.today - 1).to_time
        )
      end

      let(:params) { { chat_id: current_chat.id } }
      let(:result) { described_class.call(params: params) }
    
      it { expect(result.success?).to be_truthy }
      it { expect(result[:last_round].id).to eq(latest_game_round.id) }
      it { expect(result[:last_round].chat_id).to eq(current_chat.id) }

      describe 'loser' do
        
        it 'present in current chat' do
          expect(loser_chat_user.chat_id).to eq(current_chat.id)
          expect(result[:loser].id).to eq(loser.id)
        end
      end
      
      describe 'winner' do

        it 'present in current chat' do
          expect(winner_chat_user.chat_id).to eq(current_chat.id)
          expect(result[:winner].id).to eq(winner.id)
        end
      end
    end
  end

end
