# frozen_string_literal: true

RSpec.describe ChatUser, type: :model do
  it_behaves_like 'synchronizable model' do
    let(:init_attrs) { Hash[chat_id: create(:chat).id, user_id: create(:user).id] }
  end

  context 'validations' do
    subject { create(:chat_user) }

    it { is_expected.to validate_presence_of(:chat_id) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:chat_id) }
  end

  describe '#pdr_game_stat' do
    subject { chat_user.pdr_game_stat }

    let(:chat_user) { create(:chat_user) }

    context 'when stat exists' do
      let!(:pdr_game_stat) { create(:pdr_game_stat, chat_user: chat_user) }

      it { is_expected.to eq(pdr_game_stat) }
    end

    context 'when stat does not exist' do
      it { expect { subject }.to change { PdrGame::Stat.count }.by(1) }
    end
  end
end