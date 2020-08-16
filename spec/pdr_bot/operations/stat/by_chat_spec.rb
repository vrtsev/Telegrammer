RSpec.describe PdrBot::Op::GameStat::ByChat do
  let(:chat)   { Fabricate(:pdr_bot_chat) }
  let(:result) { described_class.call(chat: chat) }

  context 'when not found' do
    it { expect(result.failure?).to be_truthy }
    it { expect(I18n.t('.pdr_bot.stats.not_found')).to include(result[:error]) }
  end

  context 'when present' do
    let!(:winner_chat_user)  { Fabricate(:pdr_bot_chat_user, chat_id: chat.id) }
    let!(:loser_chat_user)  { Fabricate(:pdr_bot_chat_user, chat_id: chat.id) }

    describe 'winner stat' do
      let!(:winner_stat) do
        Fabricate(:pdr_bot_stat,
          chat_id: winner_chat_user.chat_id,
          user_id: winner_chat_user.user_id
        )
      end

      it { expect(result[:winner_stat].id).to eq(winner_stat.id) }
      it { expect(result[:winner].id).to eq(winner_stat.user_id) }
    end

    describe 'loser stat' do
      let!(:loser_stat) do
        Fabricate(:pdr_bot_stat,
          chat_id: loser_chat_user.chat_id,
          user_id: loser_chat_user.user_id
        )
      end

      it { expect(result[:loser_stat].id).to eq(loser_stat.id)}
      it { expect(result[:loser].id).to eq(loser_stat.user_id)}
    end
  end

end
