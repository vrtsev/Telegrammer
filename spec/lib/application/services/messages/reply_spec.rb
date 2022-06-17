# frozen_string_literal: true

RSpec.describe Messages::Reply do
  subject { described_class.call(params) }

  let(:bot) { create(:bot, name: 'example_bot', username: 'example_bot') }
  let(:chat) { create(:chat) }
  let(:bot_user) { create(:bot_user, bot: bot) }
  let!(:chat_bot_user) { create(:chat_user, chat: chat, user: bot_user) }
  let!(:reply_message) { create(:message, chat_user: chat_bot_user, bot: bot) }

  let(:params) do
    {
      bot_id: bot.id,
      chat_id: chat.id,
      text: 'Message text',
      reply_markup: { keyboard: [['One'], ['Two']] },
      delay: 2,
      message_id: reply_message.id
    }
  end

  let(:client_response) do
    {
      message_id: 1234,
      from: { id: 123456, is_bot: true, first_name: "dev_bot", username: "dev_bot"},
      chat: { id: 654321, first_name: "Chat", username: "dev_chat", type: "private"},
      date: 1655241255,
      reply_to_message: {
        message_id: 1717,
        from: { id: 123456, is_bot: true, first_name: "dev_bot", username: "dev_bot"},
        chat: { id: 654321, first_name: "Chat", username: "dev_chat", type: "private"},
        date: 1655242110,
        text: "Response text"
      },
      text: "Reply text"
    }
  end

  before do
    allow_any_instance_of(described_class).to receive(:sleep)
    allow_any_instance_of(Telegram::AppManager::Client).to receive(:reply_message).and_return(client_response)
  end

  it { expect(subject.success?).to be_truthy }

  it 'delays message send' do
    expect_any_instance_of(described_class).to receive(:sleep).with(2)
    subject
  end

  it 'calls bot api' do
    expect_any_instance_of(Telegram::AppManager::Client).to receive(:reply_message).with(
      text: params[:text],
      chat_id: chat.external_id,
      reply_to_message_id: reply_message.external_id,
      reply_markup: params[:reply_markup]
    )

    subject
  end

  it { expect { subject }.to change(chat.messages, :count).by(1) }

  it 'sets proper attributes' do
    expect(subject.message).to have_attributes(
      chat_user_id: chat_bot_user.id,
      payload_type: 'text',
      external_id: client_response[:message_id],
      text: client_response[:text],
      bot_id: bot.id,
      reply_to_id: reply_message.id,
      created_at: Time.at(client_response[:date]),
      updated_at: Time.at(client_response[:date])
    )
  end
end
