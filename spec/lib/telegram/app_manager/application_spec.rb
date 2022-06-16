# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Application do
  let(:app_name) { 'ExampleBot' }
  let(:environment) { 'development' }
  let(:telegram_bot) { Telegram.bots[:example_bot] }
  let(:controller) { ExampleBot::Controller }
  let(:controller_action_logging) { true }
  let(:config) do
    instance_double(Telegram::AppManager::Configuration,
                    app_name: app_name,
                    environment: environment,
                    telegram_bot: telegram_bot,
                    controller: controller,
                    controller_action_logging: controller_action_logging)
  end

  before { allow(Telegram::AppManager).to receive(:config).and_return(config) }

  describe '.config' do
    subject { described_class.config }

    it { is_expected.to eq(config) }
  end

  describe '.run' do
    subject { described_class.run }

    before do
      allow(config).to receive(:validate!).and_return(true)
      allow_any_instance_of(Telegram::Bot::UpdatesPoller).to receive(:start)
    end

    it 'validates app config' do
      expect(config).to receive(:validate!).once
      subject
    end

    it 'calls updates poller' do
      expect_any_instance_of(Telegram::Bot::UpdatesPoller).to receive(:start).once
      subject
    end
  end
end
