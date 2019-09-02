RSpec.describe JeniaBot::Op::Question::GetLast do
  let(:result) { described_class.call }

  it { expect(result).to be_truthy }

  describe 'trigger messages' do
    context 'when does not exist' do
      it 'returns nothing' do
        expect(result[:questions]).to be_a_kind_of(Array)
        expect(result[:questions]).to be_empty
      end
    end

    context 'when exists' do
      let(:questions) { Fabricate.times(4, :jenia_bot_question) }

      it 'returns mapped messages' do
        expect(questions.map(&:text)).to include(*result[:questions])
      end
    end
  end
end
