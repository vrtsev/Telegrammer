# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Builders::ChatUser do
  describe '.build' do
    subject { described_class.build(**params) }

    let(:params) { Hash[chat: chat, user: user] }
    let(:chat) { create(:chat) }
    let(:user) { create(:user) }

    it 'returns hash with proper attributes' do
      is_expected.to eq(
        chat_id: chat.id,
        user_id: user.id,
        deleted_at: nil
      )
    end
  end
end
