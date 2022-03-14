# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Application do
  describe '.run' do
    subject { described_class.run }

    let(:app_name) { 'ExampleBot' }
    let(:telegram_bot) { Telegram.bots[:example_bot] }
    let(:controller) { ExampleBot::Controller }
    let(:controller_logging) { true }
    let(:config) do
      instance_double(Telegram::AppManager::Configuration,
                      app_name: app_name,
                      telegram_bot: telegram_bot,
                      controller: controller,
                      controller_logging: controller_logging)
    end

    before { allow(described_class).to receive(:config).and_return(config) }

    it 'calls poller' do
      expect(Telegram::Bot::UpdatesPoller).to receive(:start).with(telegram_bot, controller)
      subject
    end
  end
end
