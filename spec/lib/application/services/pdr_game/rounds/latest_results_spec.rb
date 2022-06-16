# frozen_string_literal: true

RSpec.describe PdrGame::Rounds::LatestResults do
  subject { described_class.call(params) }

  let(:params) { Hash[chat_id: chat.id] }
  let(:chat) { create(:chat) }

  context 'and latest round exists' do
    let!(:game_round) { create(:pdr_game_round, chat: chat, winner: winner, loser: loser) }
    let(:winner) { create(:user) }
    let(:loser) { create(:user) }

    it { expect(subject.winner.id).to eq(winner.id) }
    it { expect(subject.loser.id).to eq(loser.id) }
  end

  context 'and latest round does not exist' do
    it { expect(subject.exception.error_code).to eq('PDR_GAME_NO_ROUNDS') }
  end
end
