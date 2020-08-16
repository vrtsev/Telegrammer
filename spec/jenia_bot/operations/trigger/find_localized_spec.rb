RSpec.describe JeniaBot::Op::Trigger::FindLocalized do
  context 'when params is not valid' do
    let(:params) { { message_text: '' } }
    let(:result) { described_class.call(params: params) }

    it { expect(result.failure?).to be_truthy }

    it 'contains failed validation result' do
      expect(result[:validation_result].errors.to_h).to include(*params.keys)
    end

    it 'contains error message' do
      expect(result[:error]).to include('Validation error:')
    end
  end

  context 'when params is valid' do
    let(:message_text) { I18n.t('.jenia_bot.triggers').sample }
    let(:params) { { message_text: message_text } }
    let(:result) { described_class.call(params: params) }

    describe 'trigger' do
      context 'when exists' do
        it { expect(I18n.t('.jenia_bot.triggers')).to include(result[:trigger]) }
      end

      context 'when does not exist' do
        let(:message_text) { Faker::Lorem.word }

        it { expect(result.success?).to be_falsey }
      end
    end
  end
end
