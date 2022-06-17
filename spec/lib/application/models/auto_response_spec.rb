# frozen_string_literal: true

RSpec.describe AutoResponse, type: :model do
  context 'validations' do
    subject { create(:auto_response) }

    it { is_expected.to validate_presence_of(:author_id) }
    it { is_expected.to validate_presence_of(:chat_id) }
    it { is_expected.to validate_presence_of(:bot_id) }
    it { is_expected.to validate_presence_of(:trigger) }
    it { is_expected.to validate_presence_of(:response) }
  end
end