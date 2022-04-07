# frozen_string_literal: true

RSpec.shared_examples_for 'invalid service' do
  context 'when params invalid' do
    let(:params) { nil }

    it { expect { subject }.to raise_error(described_class::ValidationError) }
  end
end
