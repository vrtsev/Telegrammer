RSpec.describe PdrBot::Op::Game::Run do
  let(:current_chat) { Fabricate(:pdr_bot_chat) }
  let(:current_user) { Fabricate(:pdr_bot_user) }
  let(:current_chat_user) { Fabricate(:pdr_bot_chat_user, chat_id: current_chat.id, user_id: current_user.id) }
  let(:result) { described_class.call(chat: current_chat, user: current_user) }

  describe 'chat last round' do
    context "when performed earlier than #{described_class::LAST_ROUND_DATE_STEP} day" do
      before do
        Fabricate(:pdr_bot_game_round, chat_id: current_chat.id)
      end

      it { expect(result.failure?).to be_truthy }
      it { expect(PdrBot.localizer.samples('game.not_allowed')).to include(result[:error]) }
    end

    context do
      context "when performed #{described_class::LAST_ROUND_DATE_STEP}" do
        let!(:chat_user) { Fabricate(:pdr_bot_chat_user, chat_id: current_chat.id, user_id: current_user.id) }
        let!(:last_round) do
          Fabricate(:pdr_bot_game_round,
            chat_id: current_chat.id,
            created_at: (Date.today - 2).to_time
          )
        end

        it { expect(result.failure?).to be_truthy }
        it { expect(PdrBot.localizer.samples('game.not_allowed')).not_to include(result[:error]) }
      end

      describe 'users' do
        before do
          ::PdrBot::GameRound.truncate
        end

        context "when less than #{described_class::MINIMUM_USER_COUNT}" do
          let!(:current_chat_users) { Fabricate.times(1, :pdr_bot_chat_user, chat_id: current_chat.id) }

          it { expect(result.failure?).to be_truthy }
          it { expect(PdrBot.localizer.samples('game.not_enough_users', min_count: described_class::MINIMUM_USER_COUNT )).to include(result[:error]) }
        end

        context "when greater that #{described_class::MINIMUM_USER_COUNT}" do
          let!(:current_chat_users) { Fabricate.times(4, :pdr_bot_chat_user, chat_id: current_chat.id) }
          let!(:another_chat_users) { Fabricate.times(4, :pdr_bot_chat_user) }

          it { expect(current_chat_users.map(&:user_id)).to include(result[:loser].id) }

          it { expect(current_chat_users.map(&:user_id)).to include(result[:winner].id) }

          it 'saves game round' do
            expect(result[:game_round].chat_id).to eq(current_chat.id)
            expect(result[:game_round].initiator_id).to eq(current_user.id)
            expect(result[:game_round].winner_id).to eq(result[:winner].id)
            expect(result[:game_round].loser_id).to eq(result[:loser].id)
          end

          it 'returns winner chat stat' do
            expect(result[:winner_stat].user_id).to eq(result[:winner].id)
            expect(result[:winner_stat].chat_id).to eq(current_chat.id)
          end

          it 'returns loser chat stat' do
            expect(result[:loser_stat].user_id).to eq(result[:loser].id)
            expect(result[:loser_stat].chat_id).to eq(current_chat.id)
          end
        end
      end
    end
  end
end
