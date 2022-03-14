# frozen_string_literal: true

RSpec.describe ExampleBot::Responders::AutoResponse, type: :responder, telegram_bot: :poller do
  subject { responder_for(bot, params) }

  let(:bot) { Telegram.bots[:example_bot] }
  let(:message_params) { Hash[chat_id: current_chat.external_id, reply_to_message_id: current_message.external_id] }

  context 'when response param is present' do
    let(:params) { Hash[response: response] }
    let(:response) { 'Sample response' }

    it { expect { subject }.to send_telegram_message(bot, 'Sample response', message_params) }
  end

  context 'when response param is not present' do
    let(:params) { Hash[] }

    it { expect { subject }.to send_telegram_message(bot, /#{current_message.text}/, message_params) }
  end
end
