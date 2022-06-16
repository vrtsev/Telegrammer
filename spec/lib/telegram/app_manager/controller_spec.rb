# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Controller, type: :controller, telegram_bot: :poller do
  let(:instance) { described_class.new(bot, payload) }
  let(:bot) { Telegram.bots[:example_bot] }
  let(:exception) { RuntimeError.new }
  # Hack to avoid `let(:data) { "callback query data here" }` is required' from telegram-bot gem
  let(:data) { nil }

  describe '#exception_handler' do
    subject { instance.send(:exception_handler, exception) }

    before do
      allow(Telegram::AppManager).to receive(:environment).and_return(environment)
      allow_any_instance_of(described_class).to receive(:handle_exception)
    end

    context 'when AppManager environment is not test' do
      let(:environment) { 'development' }

      it do
        expect_any_instance_of(described_class).to receive(:handle_exception).with(exception)
        subject
      end
    end

    context 'when AppManager environment is test' do
      let(:environment) { 'test' }

      it { expect { subject }.to raise_error(exception) }
    end
  end

  describe '#handle_exception' do
    subject { instance.send(:handle_exception, exception) }

    let(:logger) { instance_double(Telegram::AppManager::Logger) }

    before { allow(Telegram::AppManager).to receive(:logger).and_return(logger) }

    it { expect(logger).to receive(:error).once; subject }
  end
end
