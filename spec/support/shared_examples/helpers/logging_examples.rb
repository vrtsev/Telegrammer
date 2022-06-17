RSpec.shared_examples 'helpers/logging_examples' do
  before do
    allow(described_class).to receive(:logger).and_return(logger)
    allow_any_instance_of(described_class).to receive(:logger).and_return(logger)
  end

  let(:logger) do
    instance_double(Telegram::AppManager::Logger, debug: true,
                                                  info: true,
                                                  warn: true,
                                                  error: true,
                                                  fatal: true)
  end

  it { expect(described_class.logger).to eq(logger) }
end
