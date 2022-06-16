# frozen_string_literal: true

RSpec.describe Messages::Edit do
  subject { described_class.call(params) }

  let(:bot) { create(:bot, name: 'example_bot', username: 'example_bot') }
  let(:chat) { create(:chat) }
  let(:bot_user) { create(:bot_user, bot: bot) }
  let!(:chat_bot_user) { create(:chat_user, chat: chat, user: bot_user) }
  let!(:edit_message) { create(:message, chat_user: chat_bot_user, text: 'Initial text', bot: bot) }

  let(:params) do
    {
      bot_id: bot.id,
      chat_id: chat.id,
      text: 'Updated text',
      reply_markup: { keyboard: [['One'], ['Two']] },
      delay: 2,
      message_id: edit_message.id
    }
  end

  let(:client_response) do
    {
      message_id: 1234,
      from: { id: 123456, is_bot: true, first_name: "dev_bot", username: "dev_bot" },
      chat: { id: 654321, first_name: "Chat", username: "dev_chat", type: "private" },
      edit_date: 1655243346,
      text: "Reply text"
    }
  end

  before do
    allow_any_instance_of(described_class).to receive(:sleep)
    allow_any_instance_of(Telegram::AppManager::Client).to receive(:edit_message).and_return(client_response)
  end

  it { expect(subject.success?).to be_truthy }

  it 'delays message send' do
    expect_any_instance_of(described_class).to receive(:sleep).with(2)
    subject
  end

  it 'calls bot api' do
    expect_any_instance_of(Telegram::AppManager::Client).to receive(:edit_message).with(
      text: params[:text],
      chat_id: chat.external_id,
      message_id: edit_message.external_id
    )

    subject
  end

  it { expect { subject }.not_to change(chat.messages, :count) }

  it 'updates message attributes' do
    Timecop.freeze(Time.now) do
      expect { subject }.to change { edit_message.reload.text }.from('Initial text').to('Updated text')
        .and change { edit_message.reload.updated_at }.from(edit_message.updated_at).to(Time.at(client_response[:edit_date]))
    end
  end
end
