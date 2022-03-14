# frozen_string_literal: true

RSpec.describe PdrBot::Responders::ServiceError, type: :responder, telegram_bot: :poller do
  subject { responder_for(bot, params) }

  let(:bot) { Telegram.bots[:pdr_bot] }
  let(:message_params) { Hash[chat_id: current_chat.external_id] }

  it_should_behave_like 'invalid service'

  context 'when error code param is present' do
    let(:params) { Hash[error_code: error_code] }

    context 'and it is PDR_GAME_LATEST_ROUND_NOT_EXPIRED' do
      let(:error_code) { 'PDR_GAME_LATEST_ROUND_NOT_EXPIRED' }

      it { expect { subject }.to send_telegram_message(bot, nil, message_params) }
    end

    context 'and it is PDR_GAME_NOT_ENOUGH_USERS' do
      let(:error_code) { 'PDR_GAME_NOT_ENOUGH_USERS' }

      it { expect { subject }.to send_telegram_message(bot, nil, message_params) }
    end

    context 'and it is PDR_GAME_STATS_NOT_FOUND' do
      let(:error_code) { 'PDR_GAME_STATS_NOT_FOUND' }

      it { expect { subject }.to send_telegram_message(bot, nil, message_params) }
    end

    context 'and it is PDR_GAME_NO_ROUNDS' do
      let(:error_code) { 'PDR_GAME_NO_ROUNDS' }

      it { expect { subject }.to send_telegram_message(bot, nil, message_params) }
    end
  end
end
