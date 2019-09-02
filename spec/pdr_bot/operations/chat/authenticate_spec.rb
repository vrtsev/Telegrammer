RSpec.describe PdrBot::Op::Chat::Authenticate do
  let(:chat)   { Fabricate(:pdr_bot_chat) }
  let(:result) { described_class.call(chat: chat) } 

  context 'when chat is approved' do
    it { expect(result[:approved]).to be_truthy }
  end

  context 'when chat is not approved' do
    let(:chat) { Fabricate(:pdr_bot_chat, approved: false) }
    it { expect(result[:approved]).to be_falsey }
  end
end

