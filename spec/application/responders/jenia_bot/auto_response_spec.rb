# frozen_string_literal: true

RSpec.describe JeniaBot::Responders::AutoResponse, type: :responder, telegram_bot: :poller do
  subject { responder_for(bot, params) }

  let(:bot) { Telegram.bots[:jenia_bot] }
  let(:message_params) { Hash[chat_id: current_chat.external_id, reply_to_message_id: current_message.external_id] }

  context 'when response param is not present' do
    let(:params) { Hash[] }

    it { expect { subject }.not_to send_telegram_message(bot, nil, message_params) }
  end

  context 'when response param is present' do
    let(:params) { Hash[response: response] }
    let(:response) { 'Sample response' }

    it { expect { subject }.to send_telegram_message(bot, 'Sample response', message_params) }
  end
end