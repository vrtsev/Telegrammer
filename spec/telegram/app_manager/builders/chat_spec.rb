# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Builders::Chat do
  describe '.build' do
    subject { described_class.build(**params) }

    let(:params) { Hash[chat: chat_payload, bot_setting: bot_setting] }
    let(:bot_setting) { create(:bot_setting) }
    let(:chat_payload) do
      Telegram::Bot::Types::Chat.new(
        id: 123456789,
        type: 'private',
        title: 'Chat title',
        username: 'username',
        first_name: 'First name',
        last_name: 'Last name',
        description: 'Chat description',
        invite_link: 'https://t.me/invite_link',
        all_members_are_administrators: false
      )
    end

    it 'returns hash with proper attributes' do
      is_expected.to eq(
        external_id: 123456789,
        approved: bot_setting.autoapprove_chat,
        chat_type: Chat.chat_types[:private_chat],
        title: 'Chat title',
        username: 'username',
        first_name: 'First name',
        last_name: 'Last name',
        description: 'Chat description',
        invite_link: 'https://t.me/invite_link',
        all_members_are_administrators: false
      )
    end
  end
end
