# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Builder do
  describe '.build' do
    subject { described_class.build(arg: :value) }

    it 'calls "to_h" method on instance' do
      expect_any_instance_of(described_class).to receive(:to_h)
      subject
    end
  end

  describe '#to_h' do
    subject { described_class.new(key: :value).to_h }

    it { expect { subject }.to raise_error("Implement method `to_h` in #{described_class}") }
  end
end
