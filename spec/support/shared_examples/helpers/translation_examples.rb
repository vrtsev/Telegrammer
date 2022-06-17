RSpec.shared_examples 'helpers/translation_examples' do
  before { allow_any_instance_of(described_class).to receive(:t).and_return(stubbed_text) }

  let(:stubbed_text) { 'Stubbed text' }
end
