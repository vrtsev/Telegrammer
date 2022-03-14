# frozen_string_literal: true

RSpec.describe JeniaBot::Responders::ServiceError, type: :responder, telegram_bot: :poller do
  subject { responder_for(bot) }

  let(:bot) { Telegram.bots[:jenia_bot] }

  context 'when error code param is not present' do
    let(:params) { Hash[] }

    it { expect { subject }.to raise_error(described_class::ValidationError) }
  end
end
