# frozen_string_literal: true

RSpec.shared_context 'controller_helpers' do
  let(:bot) { raise "implement 'let(:bot)' variable in your specs" }
  let!(:bot_setting) { create(:bot_setting, bot: bot.username) }
  let(:payload_text) { raise "implement 'let(:payload_text)' variable in your specs" }
  let(:current_chat) { create(:chat) }
  let(:chat) { current_chat }
  let(:current_user) { create(:user) }
  let(:from) { current_user }
  let(:current_chat_user) { create(:chat_user, chat: current_chat, user: current_user) }
  let(:current_message) { create(:message, chat_user: current_chat_user) }
  let(:left_chat_member) { nil }
  let(:payload) do
    Telegram::Bot::Types::Message.new(
      message_id: current_message.external_id,
      left_chat_member: left_chat_member,
      from: Telegram::Bot::Types::User.new(
        id: current_user.external_id,
        is_bot: current_user.is_bot?,
        first_name: current_user.first_name,
        last_name: current_user.last_name,
        username: current_user.username,
        language_code: 'en'
      ),
      chat: Telegram::Bot::Types::Chat.new(
        id: current_chat.external_id,
        first_name: current_chat.first_name,
        username: current_chat.username,
        type: current_chat.chat_type
      ),
      date: Time.now.to_i,
      text: payload_text
    )
  end

  def expect_response(responder_class, params=nil)
    expectation = expect(responder_class).to receive(:call)
    expectation.with(hash_including(params: params)) if params.present?
    expectation
  end
end