# frozen_string_literal: true

RSpec.describe Message, type: :model do
  context 'validations' do
    subject { create(:message) }

    it { is_expected.to validate_presence_of(:chat_user_id) }
    it { is_expected.to validate_presence_of(:payload_type) }
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_presence_of(:bot_id) }
    it { is_expected.to validate_uniqueness_of(:external_id).scoped_to(:bot_id) }
  end

  describe '#mark_as_deleted!' do
    subject { message.mark_as_deleted! }

    let(:message) { create(:message, deleted_at: nil) }

    it 'updates "deleted_at" attribute' do
      Timecop.freeze(Time.now) do
        expect { subject }.to change { message.reload.deleted_at }.from(nil).to(Time.now)
      end
    end
  end
end