# frozen_string_literal: true

RSpec.describe Message, type: :model do
  it_behaves_like 'synchronizable model' do
    let(:init_attrs) { Hash[external_id: Faker::Number.number(digits: 8)] }
  end

  context 'validations' do
    subject { create(:message) }

    it { is_expected.to validate_presence_of(:chat_user_id) }
    it { is_expected.to validate_presence_of(:payload_type) }
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_uniqueness_of(:external_id) }
  end
end