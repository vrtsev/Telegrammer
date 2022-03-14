# frozen_string_literal: true

RSpec.describe PdrGame::Stats::ByChat do
  subject { described_class.call(params) }

  it_should_behave_like 'invalid service'

  context 'when params valid' do
    let(:params) { Hash[chat_id: chat.id] }
    let(:chat) { create(:chat) }

    context 'and stats exists' do
      let(:first_chat_user) { create(:chat_user, chat: chat) }
      let(:second_chat_user) { create(:chat_user, chat: chat) }

      let!(:stats) { [first_stat, second_stat] }
      let(:first_stat) { create(:pdr_game_stat, chat_user: first_chat_user) }
      let(:second_stat) { create(:pdr_game_stat, chat_user: second_chat_user) }

      it { expect(subject.chat_stats.ids).to eq(stats.map(&:id)) }
    end

    context 'and latest round does not exist' do
      it { expect(subject.exception.error_code).to eq('PDR_GAME_STATS_NOT_FOUND') }
    end
  end
end
