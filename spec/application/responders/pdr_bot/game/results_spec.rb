# frozen_string_literal: true

RSpec.describe PdrBot::Responders::Game::Results, type: :responder, telegram_bot: :poller do
  subject { responder_for(bot, params) }

  let(:bot) { Telegram.bots[:pdr_bot] }
  let(:message_params) { Hash[chat_id: current_chat.external_id] }

  it_should_behave_like 'invalid service'

  context 'when params are valid' do
    let(:params) do
      Hash[
        winner_name: Faker::Name.name,
        loser_name: Faker::Name.name
      ]
    end

    it { expect { subject }.to send_telegram_message(bot, nil, message_params) }
  end

end
