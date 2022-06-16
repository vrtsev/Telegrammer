# frozen_string_literal: true

RSpec.describe Messages::Delete do
  subject { described_class.call(params) }

  let(:bot) { create(:bot, name: 'example_bot', username: 'example_bot') }
  let(:chat) { create(:chat) }
  let(:bot_user) { create(:bot_user, bot: bot) }
  let!(:chat_bot_user) { create(:chat_user, chat: chat, user: bot_user) }
  let!(:delete_message) { create(:message, chat_user: chat_bot_user, bot: bot) }

  let(:params) do
    {
      bot_id: bot.id,
      chat_id: chat.id,
      delay: 2,
      message_id: delete_message.id
    }
  end

  before do
    allow_any_instance_of(described_class).to receive(:sleep)
    allow_any_instance_of(Telegram::AppManager::Client).to receive(:delete_message)
    allow(delete_message).to receive(:mark_as_deleted!)
  end

  it { expect(subject.success?).to be_truthy }

  it 'delays message send' do
    expect_any_instance_of(described_class).to receive(:sleep).with(2)
    subject
  end

  it 'calls bot api' do
    expect_any_instance_of(Telegram::AppManager::Client).to receive(:delete_message).with(
      chat_id: chat.external_id,
      message_id: delete_message.external_id
    )

    subject
  end

  it { expect { subject }.not_to change(chat.messages, :count) }
end
