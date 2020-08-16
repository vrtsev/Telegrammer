# frozen_string_literal: false

RSpec.describe PdrBot::Op::Message::DeleteOld do
  let(:old_message_date) { Date.today - (described_class::OLD_MESSAGES_AGE + 5) }
  let!(:old_messages_ids) do
    Fabricate.times(4, :pdr_bot_message, created_at: old_message_date.to_time).map(&:id)
  end

  let!(:new_messages_ids) do
    Fabricate.times(4, :pdr_bot_message, created_at: Date.today.to_time).map(&:id)
  end

  it { expect(described_class.call.success?).to be_truthy }

  it 'deletes messages that older than specified constant days value' do
    described_class.call
    message_ids = PdrBot::Message.all.map(&:id)

    expect(message_ids).not_to include(*old_messages_ids)
    expect(message_ids).to include(*new_messages_ids)
  end
end
