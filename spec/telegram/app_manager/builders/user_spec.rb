# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Builders::User do
  describe '.build' do
    subject { described_class.build(**params) }

    let(:params) { Hash[user: user_payload] }
    let(:bot_setting) { create(:bot_setting) }
    let(:user_payload) do
      Telegram::Bot::Types::User.new(
        id: 123456789,
        username: 'username',
        first_name: 'First name',
        last_name: 'Last name',
        is_bot: false
      )
    end

    it 'returns hash with proper attributes' do
      is_expected.to eq(
        external_id: 123456789,
        username: 'username',
        first_name: 'First name',
        last_name: 'Last name',
        is_bot: false
      )
    end
  end
end
