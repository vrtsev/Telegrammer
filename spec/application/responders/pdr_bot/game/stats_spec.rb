# frozen_string_literal: true

RSpec.describe PdrBot::Responders::Game::Stats, type: :responder, telegram_bot: :poller do
  subject { responder_for(bot, params) }

  let(:bot) { Telegram.bots[:pdr_bot] }
  let(:message_params) { Hash[chat_id: current_chat.external_id] }

  it_should_behave_like 'invalid service'

  context 'when params are valid' do
    let(:chat_stat) { create(:pdr_game_stat) }
    let(:winner_leader_stat) { create(:pdr_game_stat) }
    let(:loser_leader_stat) { create(:pdr_game_stat) }
    let(:params) do
      Hash[
        winner_leader_stat: winner_leader_stat,
        loser_leader_stat: loser_leader_stat,
        chat_stats: [chat_stat]
      ]
    end

    it { expect { subject }.to send_telegram_message(bot, nil, message_params) }
  end
end
