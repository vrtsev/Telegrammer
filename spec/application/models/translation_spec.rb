# frozen_string_literal: true

RSpec.describe Translation, type: :model do
  context 'validations' do
    subject { build(:translation) }

    it { is_expected.to validate_presence_of(:key) }
    it { is_expected.to validate_uniqueness_of(:key).scoped_to(:chat_id) }
  end

  describe '.for' do
    subject { described_class.for(key) }

    context 'when key is not registered' do
      let(:key) { 'not.registered.key' }

      it { expect { subject }.to raise_error("key is not registered: #{key}") }
    end
  end
end