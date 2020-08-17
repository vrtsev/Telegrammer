# frozen_string_literal: false

RSpec.describe JeniaBot::Op::Chat::Authenticate do
  let(:chat)   { Fabricate(:jenia_bot_chat) }
  let(:params) { { chat_id: chat.id } }
  let(:result) { described_class.call(params: params) }

  context 'when chat is approved' do
    it { expect(result[:approved]).to be_truthy }
  end

  context 'when chat is not approved' do
    let(:chat) { Fabricate(:jenia_bot_chat, approved: false) }
    it { expect(result[:approved]).to be_falsey }
  end
end
