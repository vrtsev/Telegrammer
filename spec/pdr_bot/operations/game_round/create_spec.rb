RSpec.describe PdrBot::Op::GameRound::Create do
  context 'when params is not valid' do
    let(:params) do
      {
        chat_id: 'string',
        initiator_id: 'string',
        winner_id: 'string',
        loser_id: 'string'
      }
    end
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
    let(:chat)      { Fabricate(:pdr_bot_chat) }
    let(:initiator) { Fabricate(:pdr_bot_user) }
    let(:winner)    { Fabricate(:pdr_bot_user) }
    let(:loser)     { Fabricate(:pdr_bot_user) }
    let(:params) do
      {
        chat_id: chat.id,
        initiator_id: initiator.id,
        winner_id: winner.id,
        loser_id: loser.id
      }
    end
    let(:result) { described_class.call(params: params) }

    it { expect(result.success?).to be_truthy }
    it { expect(result[:game_round].chat_id).to eq(params[:chat_id]) }
    it { expect(result[:game_round].initiator_id).to eq(params[:initiator_id]) }
    it { expect(result[:game_round].winner_id).to eq(params[:winner_id]) }
    it { expect(result[:game_round].loser_id).to eq(params[:loser_id]) }
  end
end
