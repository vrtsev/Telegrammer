# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Responder::NewChatRegistered, type: :responder, telegram_bot: :poller do
  subject { responder_for(bot, params) }

  let(:bot) { Telegram.bots[:example_bot] }
  let(:params) { Hash[chat: chat.attributes] }
  let(:chat) { create(:chat) }
  let(:message_params) { Hash[chat_id: ENV['TELEGRAM_APP_OWNER_ID']] }
  let(:app_owner_id) { 123456789 }

  before { stub_env('TELEGRAM_APP_OWNER_ID', app_owner_id) }

  it { expect { subject }.to send_telegram_message(bot, nil, message_params) }
end