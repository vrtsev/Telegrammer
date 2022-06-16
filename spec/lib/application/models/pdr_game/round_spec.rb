# frozen_string_literal: true

RSpec.describe PdrGame::Round, type: :model do
  context 'validations' do
    subject { create(:pdr_game_round) }

    it { is_expected.to validate_presence_of(:chat_id) }
    it { is_expected.to validate_presence_of(:initiator_id) }
    it { is_expected.to validate_presence_of(:loser_id) }
    it { is_expected.to validate_presence_of(:winner_id) }

    describe '#winner_loser_difference' do
      subject { build(:pdr_game_round, winner_id: user.id, loser_id: user.id) }

      let(:user) { create(:user) }

      it 'validates difference of winner_id and loser_id' do
        subject.validate
        expect(subject.errors[:winner_id]).to include('should not be equal to loser_id')
      end
    end
  end
end