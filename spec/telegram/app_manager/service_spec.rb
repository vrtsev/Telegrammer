# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Service do
  let(:params) { Hash[key: :value] }

  describe '.call' do
    subject { described_class.call(params) }

    context 'with service error raised' do
      let(:exception) { Telegram::AppManager::Service::ServiceError.new(error_code: 'ERROR_CODE') }

      before { allow_any_instance_of(described_class).to receive(:call).and_raise(exception) }

      it { expect(subject.success).to be_falsey }
      it { expect(subject.exception).to eq(exception) }
    end

    context 'without service error raised' do
      before do
        allow_any_instance_of(described_class).to receive(:validate)
        allow_any_instance_of(described_class).to receive(:call)
      end

      it 'has proper instance variables values' do
        expect(subject.exception).to be_nil
        expect(subject.success?).to be_truthy
        expect(subject.params).to eq(params)
      end

      it 'calls instance method "validate"' do
        expect_any_instance_of(described_class).to receive(:validate)
        subject
      end

      it 'calls instance method "call"' do
        expect_any_instance_of(described_class).to receive(:call)
        subject
      end
    end
  end

  describe '#call' do
    subject { described_class.new(params).call }

    it { expect { subject }.to raise_error(NotImplementedError) }
  end
end
