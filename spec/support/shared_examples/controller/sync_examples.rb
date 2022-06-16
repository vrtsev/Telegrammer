RSpec.shared_examples 'controller/sync_examples' do
  let(:current_chat) { create(:chat, approved: is_chat_approved) }
  let(:current_user) { create(:user) }
  let(:current_chat_user) { create(:chat_user, chat: current_chat, user: current_user) }
  let(:current_message) { create(:message, chat_user: current_chat_user, text: (payload_text || Faker::Lorem.sentence), bot_id: bot.id) }

  let(:is_chat_approved) { true }
  let(:payload_text) { nil }
  let(:payload) { base_payload }
  let(:base_payload) do
    {
      'message_id' => current_message.external_id,
      'from' => {
        'id' => current_user.external_id,
        'is_bot' => current_user.is_bot?,
        'first_name' => current_user.first_name,
        'last_name' => current_user.last_name,
        'username' => current_user.username,
        'language_code' => 'en'
      },
      'chat' => {
        'id' => current_chat.external_id,
        'first_name' => current_chat.first_name,
        'username' => current_chat.username,
        'type' => current_chat.chat_type
      },
      'date' => Time.now.to_i,
      'text' => current_message.text
    }
  end

  before do
    allow_service_call(Chats::Sync).and_return instance_double(Chats::Sync, chat: current_chat)
    allow_service_call(Users::Sync).and_return instance_double(Users::Sync, user: current_user)
    allow_service_call(ChatUsers::Sync).and_return instance_double(ChatUsers::Sync, chat_user: current_chat_user)
    allow_service_call(Messages::Sync).and_return instance_double(Messages::Sync, message: current_message)
  end

  describe 'sync module' do
    let(:controller_instance) { described_class.new(bot.client, base_payload) }

    describe '#sync_request' do
      subject { controller_instance.sync_request }

      before { allow_any_instance_of(described_class).to receive(:payload).and_return(base_payload) }

      it 'sets instance variables' do
        expect { subject }.to change { controller_instance.current_chat }.from(nil).to(current_chat)
          .and change { controller_instance.current_user }.from(nil).to(current_user)
          .and change { controller_instance.current_chat_user }.from(nil).to(current_chat_user)
          .and change { controller_instance.current_message }.from(nil).to(current_message)
      end

      it 'calls chat sync service' do
        expect_service_call(Chats::Sync, payload: base_payload['chat'], autoapprove: bot.autoapprove_chat, bot_id: bot.id)
      end

      it 'calls user sync service' do
        expect_service_call(Users::Sync, bot_id: nil, payload: base_payload['from'])
      end

      it 'calls chat user sync service' do
        expect_service_call(ChatUsers::Sync, chat_id: current_chat.id, user_id: current_user.id)
      end

      it 'calls message sync service' do
        expect_service_call(Messages::Sync, payload: base_payload, chat_user_id: current_chat_user.id, bot_id: bot.id)
      end
    end

    describe '#sync_bot' do
      subject { controller_instance.sync_bot }

      let(:bot_user) { instance_double(User, id: 1) }
      let(:client_get_bot_response) do
        {
          'id' => 123456789,
          'is_bot' => true,
          'first_name' => 'dev_bot',
          'username' => 'dev_bot',
          'can_join_groups' => true,
          'can_read_all_group_messages' => true,
          'supports_inline_queries' => false
        }
      end

      before do
        allow_any_instance_of(described_class).to receive(:current_chat).and_return(current_chat)
        allow_any_instance_of(Telegram::AppManager::Client).to receive(:get_bot).and_return(client_get_bot_response)
        allow_service_call(Users::Sync).and_return instance_double(Users::Sync, user: bot_user)
        allow_service_call(ChatUsers::Sync).and_return instance_double(ChatUsers::Sync, chat_user: current_chat_user)
      end

      it 'sets instance variables' do
        expect { subject }.to change { controller_instance.bot_user }.from(nil).to(bot_user)
          .and change { controller_instance.bot_chat_user }.from(nil).to(current_chat_user)
      end

      it 'calls user sync service' do
        expect_service_call(Users::Sync, bot_id: bot.id, payload: client_get_bot_response)
      end

      it 'calls chat user sync service' do
        expect_service_call(ChatUsers::Sync, chat_id: current_chat.id, user_id: bot_user.id)
      end
    end
  end
end
