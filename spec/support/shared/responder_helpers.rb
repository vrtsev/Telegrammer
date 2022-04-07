# frozen_string_literal: true

RSpec.shared_context 'responder_helpers' do
  let(:current_chat) { create(:chat) }
  let(:current_user) { create(:user) }
  let(:current_chat_user) { create(:chat_user, chat: current_chat, user: current_user) }
  let(:current_message) { create(:message, chat_user: current_chat_user) }

  before do
    allow_any_instance_of(described_class).to receive(:current_chat).and_return(current_chat)
    allow_any_instance_of(described_class).to receive(:current_user).and_return(current_user)
    allow_any_instance_of(described_class).to receive(:current_chat_user).and_return(current_chat_user)
    allow_any_instance_of(described_class).to receive(:current_message).and_return(current_message)
  end

  def responder_for(bot, params={})
    described_class.call(context: nil, bot: bot, params: params)
  end
end
