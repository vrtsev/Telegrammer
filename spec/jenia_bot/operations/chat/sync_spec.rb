# frozen_string_literal: false

RSpec.describe JeniaBot::Op::Chat::Sync do
  context 'when params is not valid' do
    let(:params) { { id: 'string', type: 123 } }
    let(:result) { described_class.call(params: params) }

    it { expect(result.failure?).to be_truthy }

    it 'contains failed validation result' do
      expect(result[:validation_result].errors.to_h).to include(:id, :type)
    end

    it 'contains error message' do
      expect(result[:error]).to include('Validation error:')
    end
  end

  context 'when params is valid' do
    let(:chat_type) { 'private' }
    let(:result) { described_class.call(params: params) }

    context 'when chat exists' do
      let(:params) { { id: chat.id, type: chat_type } }
      let(:chat)   { Fabricate(:jenia_bot_chat, type: ::JeniaBot::Chat::Types.private) }

      it 'returns chat' do
        expect(result[:chat]).to eq(chat)
      end
    end

    context 'chat does not exist' do
      let(:params) { { id: 999, type: chat_type } }

      before do
        expect_any_instance_of(::Telegram::AppManager::Message).to receive(:send)
      end

      it 'creates and returns chat' do
        expect(result[:chat].id).to eq(params[:id])
        expect(result[:chat].type).to eq(::JeniaBot::Chat::Types.value(chat_type))
        expect(result[:chat].title).to eq(params[:title])
      end
    end
  end
end
