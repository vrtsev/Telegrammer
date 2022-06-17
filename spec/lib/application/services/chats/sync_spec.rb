# frozen_string_literal: true

RSpec.describe Chats::Sync do
  subject { described_class.call(params) }

  let(:bot) { create(:bot, name: 'example_bot', username: 'example_bot') }
  let(:chat) { create(:chat) }
  let(:params) do
    {
      bot_id: bot.id,
      autoapprove: true,
      payload: {
        id: 12345678,
        type: 'private',
        title: 'Title',
        username: 'username',
        first_name: 'First name',
        last_name: 'Last name',
        description: 'description',
        invite_link: 'https://t.me/link'
      }
    }
  end

  before do
    allow(Chat).to receive(:sync_by!).and_return(chat)
    allow_any_instance_of(Telegram::AppManager::Client).to receive(:chat_photo_url)
  end

  it { expect(subject.success?).to be_truthy }

  it 'gets chat photo url' do
    expect_any_instance_of(Telegram::AppManager::Client).to receive(:chat_photo_url).with(12345678)
    subject
  end

  it 'calls sync_by! on Chat model' do
    expect(Chat).to receive(:sync_by!)
      .with(:external_id, {
        external_id: 12345678,
        approved: true,
        chat_type: 'private',
        title: 'Title',
        username: 'username',
        first_name: 'First name',
        last_name: 'Last name',
        description: 'description',
        invite_link: 'https://t.me/link'
      }).once

    subject
  end
end
