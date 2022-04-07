# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Worker do
  describe '.perform' do
    subject { described_class.perform_async }

    it { expect { subject }.to raise_error("Implement method `perform` in #{described_class}") }
  end
end
