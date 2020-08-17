# frozen_string_literal: false

RSpec.describe PdrBot::Op::GameRound::Delete do
  context 'when params is not valid' do
    let(:params) { { game_round_id: 'string' } }
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
    let(:chat) { Fabricate(:pdr_bot_chat) }
    let(:result) { described_class.call(params: params) }

    describe 'game round' do
      context 'when exists' do
        let(:game_round) { Fabricate(:pdr_bot_game_round) }
        let(:params) { { game_round_id: game_round.id } }

        it { expect(result.success?).to be_truthy }
      end

      context 'when does not exist' do
        let(:params) { { game_round_id: 9999 } }

        it 'is failed' do
          expect(result.success?).to be_falsey
        end

        it 'contains error message' do
          expect(result[:error]).to include('Could not find record')
        end
      end
    end
  end
end
