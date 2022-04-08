# frozen_string_literal: true

RSpec.describe JeniaBot::Responders::CallJenia, type: :responder, telegram_bot: :poller do
  subject { responder_for(bot, params) }

  let(:bot) { Telegram.bots[:jenia_bot] }

  context 'when response param is not present' do
    let(:params) { Hash[response: nil] }
    let(:message_params) { Hash[chat_id: current_chat.external_id, reply_to_message_id: current_message.external_id] }

    it { expect { subject }.to send_telegram_message(bot, nil, message_params) }
  end

  context 'when response param is present' do
    let(:message_params) do
      Hash[
        chat_id: current_chat.external_id,
        reply_to_message_id: current_message.external_id,
        reply_markup: reply_markup
      ]
    end
    let(:reply_markup) do
      {
        keyboard: sliced_questions,
        resize_keyboard: true,
        one_time_keyboard: true
      }
    end
    let(:response) { 'Sample response' }

    context 'and when questions param is not present' do
      let(:params) { Hash[response: response] }
      let(:sliced_questions) { [] }

      it { expect { subject }.to send_telegram_message(bot, 'Sample response', message_params) }
    end

    context 'and when questions param is present' do
      let(:params) { Hash[response: response, questions: questions] }
      let(:questions) { ['Question1', 'Question2'] }
      let(:sliced_questions) { [['Question1'], ['Question2']] }

      it { expect { subject }.to send_telegram_message(bot, 'Sample response', message_params) }
    end
  end
end
