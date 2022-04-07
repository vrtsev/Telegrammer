# frozen_string_literal: true

RSpec.shared_examples 'synchronizable model' do
  include ActiveSupport::Inflector

  describe '.sync' do
    subject { described_class.sync(params, **init_attrs) }

    # Do not forget to define 'let(:init_attrs)' in your specs
    let(:fabricator_name) { underscore(described_class.to_s) }
    let(:params) { fabric.attributes }

    context 'when record does not exist' do
      let(:fabric) { create(fabricator_name, **init_attrs) }

      it { expect { subject }.to change { described_class.count }.by(1) }
      it { is_expected.to have_attributes(params) }
    end

    context 'when record exists' do
      let!(:fabric) { create(fabricator_name, **init_attrs) }
      let(:params) { create(fabricator_name).attributes.symbolize_keys.except(*(init_attrs.keys << :id)) }

      it { is_expected.to have_attributes(params) }
      it { expect(subject.id).to eq(fabric.id) }
    end
  end
end
