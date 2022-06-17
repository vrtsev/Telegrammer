# frozen_string_literal: true

RSpec.describe JeniaQuestion, type: :model do
  context 'validations' do
    subject { create(:jenia_question) }

    it { is_expected.to validate_presence_of(:chat_id) }
    it { is_expected.to validate_presence_of(:text) }

    it { is_expected.to validate_uniqueness_of(:text).scoped_to(:chat_id) }
    it { is_expected.to validate_length_of(:text).is_at_most(255) }
  end
end