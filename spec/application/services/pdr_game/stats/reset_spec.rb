# frozen_string_literal: true

RSpec.describe PdrGame::Stats::Reset do
  subject { described_class.call(params) }

  it_should_behave_like 'invalid service'

  context 'when params valid' do
    let(:params) { Hash[chat_id: chat.id] }
    let(:chat) { create(:chat) }
    let(:chat_user) { create(:chat_user, chat: chat) }
    let!(:chat_user_stat) { create(:pdr_game_stat, chat_user: chat_user, winner_count: 1, loser_count: 1) }

    it 'updates counters to zero' do
      expect { subject }.to change { chat_user_stat.reload.winner_count }.from(1).to(0)
    end
  end
end
