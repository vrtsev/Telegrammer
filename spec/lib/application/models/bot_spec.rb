# frozen_string_literal: true

RSpec.describe Bot, type: :model do
  context 'validations' do
    subject { create(:bot) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_uniqueness_of(:username) }
  end

  describe '#client' do
    subject { bot.client }

    let(:bot) { create(:bot, name: bot_name) }
    let(:bot_name) { :example_bot }
    let(:telegram_bots) { Hash[bot_name => bot_client] }
    let(:bot_client) { instance_double(Telegram::Bot::Client) }

    before { allow(Telegram).to receive(:bots).and_return(telegram_bots) }

    it { is_expected.to eq(bot_client) }
  end
end
