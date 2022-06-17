RSpec.shared_examples 'failed service' do |service_class|
  context 'when service is failed' do
    let(:service_result) { instance_double(service_class, success?: false, exception: exception) }
    let(:exception) { BaseService::ServiceError.new(error_code: 'ERROR') }

    before { allow_any_instance_of(described_class).to receive(:respond_with_error) }

    it 'responds with error' do
      expect_any_instance_of(described_class).to receive(:respond_with_error).once
      subject
    end
  end
end
