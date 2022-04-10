# frozen_string_literal: true

RSpec.describe PdrGame::Run do
  subject { described_class.call(params) }

  it_should_behave_like 'invalid service'

  context 'when params valid' do
    let(:params) { Hash[chat_id: chat.id, initiator_id: initiator.id] }
    let(:chat) { create(:chat) }
    let(:initiator) { create(:user) }

    context 'and when latest game round exists' do
      let!(:last_game_round) { create(:pdr_game_round, chat: chat, updated_at: round_updated_at) }

      context 'and when latest game round is not expired' do
        let(:round_updated_at) { Time.now }

        it { expect(subject.exception.error_code).to eq('PDR_GAME_LATEST_ROUND_NOT_EXPIRED') }
      end

      context 'and when latest game round is expired' do
        let(:round_updated_at) { Time.now - 2.days }

        context 'and when chat does not have minimum users count' do
          let!(:chat_users) { create_list(:chat_user, chat_users_count, chat: chat) }
          let(:chat_users_count) { described_class::MINIMUM_USER_COUNT - 1 }

          it { expect(subject.exception.error_code).to eq('PDR_GAME_NOT_ENOUGH_USERS') }
        end

        context 'and when chat has minimum users count' do
          let!(:finalists) { [winner_chat_user, loser_chat_user] }
          let!(:winner_chat_user) { create(:chat_user, chat: chat) }
          let!(:loser_chat_user) { create(:chat_user, chat: chat) }

          before { allow_any_instance_of(described_class).to receive(:finalists).and_return(finalists) }

          it 'updates winner stat' do
            expect { subject }.to change { winner_chat_user.pdr_game_stat.reload.winner_count }.by(1)
            expect { subject }.not_to change { loser_chat_user.pdr_game_stat.reload.loser_count }
          end

          it 'updates loser stat' do
            expect { subject }.to change { loser_chat_user.pdr_game_stat.reload.loser_count }.by(1)
            expect { subject }.not_to change { loser_chat_user.pdr_game_stat.reload.winner_count }
          end

          it 'saves game round' do
            expect { subject }.to change { PdrGame::Round.count }.by(0)

            expect(subject.game_round).to have_attributes(
              chat_id: chat.id,
              initiator_id: initiator.id,
              winner_id: winner_chat_user.user_id,
              loser_id: loser_chat_user.user_id
            )
          end
        end
      end
    end

    context 'and when latest game round does not exist' do
      context 'and when chat does not have minimum users count' do
        let!(:chat_users) { create_list(:chat_user, chat_users_count, chat: chat) }
        let(:chat_users_count) { described_class::MINIMUM_USER_COUNT - 1 }

        it { expect(subject.exception.error_code).to eq('PDR_GAME_NOT_ENOUGH_USERS') }
      end

      context 'and when chat has minimum users count' do
        let!(:finalists) { [winner_chat_user, loser_chat_user] }
        let!(:winner_chat_user) { create(:chat_user, chat: chat) }
        let!(:loser_chat_user) { create(:chat_user, chat: chat) }

        before { allow_any_instance_of(described_class).to receive(:finalists).and_return(finalists) }

        it 'updates winner stat' do
          expect { subject }.to change { winner_chat_user.pdr_game_stat.reload.winner_count }.by(1)
          expect { subject }.not_to change { loser_chat_user.pdr_game_stat.reload.loser_count }
        end

        it 'updates loser stat' do
          expect { subject }.to change { loser_chat_user.pdr_game_stat.reload.loser_count }.by(1)
          expect { subject }.not_to change { loser_chat_user.pdr_game_stat.reload.winner_count }
        end

        context 'when chat game round does not exist' do
          it 'saves game round' do
            expect { subject }.to change { PdrGame::Round.count }.by(1)

            expect(subject.game_round).to have_attributes(
              chat_id: chat.id,
              initiator_id: initiator.id,
              winner_id: winner_chat_user.user_id,
              loser_id: loser_chat_user.user_id
            )
          end
        end
      end
    end
  end
end
