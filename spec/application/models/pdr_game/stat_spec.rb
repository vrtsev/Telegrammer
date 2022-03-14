# frozen_string_literal: true

RSpec.describe PdrGame::Stat, type: :model do
  context 'validations' do
    subject { create(:pdr_game_stat) }

    it { is_expected.to validate_presence_of(:chat_user_id) }
    it { is_expected.to validate_uniqueness_of(:chat_user_id) }
  end
end