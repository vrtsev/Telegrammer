# frozen_string_literal: true

RSpec.describe PdrBot::Responders::Game::Start, type: :responder, telegram_bot: :poller do
  subject { responder_for(bot) }

  let(:bot) { Telegram.bots[:pdr_bot] }
  let(:message_params) { Hash[chat_id: current_chat.external_id] }

  it { expect { subject }.to send_telegram_message(bot, nil, message_params.merge(id: :title_text)) }
  it { expect { subject }.to send_telegram_message(bot, nil, message_params.merge(id: :searching_users_text)) }
end
