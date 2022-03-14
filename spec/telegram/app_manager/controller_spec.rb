# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Controller, type: :controller, telegram_bot: :poller do
  subject { described_class.dispatch('message') }

  let(:bot) { Telegram.bots[:example_bot] }
  let!(:bot_setting) { create(:bot_setting, bot: application_config.telegram_bot.username, enabled: bot_setting_enabled) }
  let(:bot_setting_enabled) { true }
  let(:controller_logging) { false }
  let(:payload_text) { 'Payload text' }
  let(:application_config) do
    instance_double(Telegram::AppManager::Configuration,
                    app_name: 'ExampleApp',
                    telegram_bot: bot,
                    controller: ExampleBot::Controller,
                    controller_logging: controller_logging)
  end

  before do
    allow(Telegram::AppManager::Application).to receive_message_chain(:config).and_return(application_config)
    allow_any_instance_of(described_class).to receive(:payload).and_return(payload)
    allow_any_instance_of(described_class).to receive(:from).and_return(payload.from)
    allow_any_instance_of(described_class).to receive(:chat).and_return(payload.chat)
    allow_any_instance_of(described_class).to receive(:current_chat).and_return(current_chat)
    allow_any_instance_of(described_class).to receive(:current_user).and_return(current_user)
    allow_any_instance_of(described_class).to receive(:current_chat_user).and_return(current_chat_user)
    allow_any_instance_of(described_class).to receive(:current_message).and_return(current_message)
  end

  describe '#enable!' do
    subject { -> { dispatch_command(:enable, payload) }.call }

    let(:payload_text) { '/enable' }
    let(:bot_setting_enabled) { false }

    context 'when current user is admin' do
      before { stub_env('TELEGRAM_APP_OWNER_ID', current_user.external_id) }

      it { expect { subject }.to change { bot_setting.reload.enabled }.from(false).to(true) }
      it 'sends telegram message' do
        expect { subject }.to send_telegram_message(bot, 'Bot has been enabled', {
          chat_id: current_chat.external_id, reply_to_message_id: current_message.external_id
        })
      end
    end

    context 'when current user is not admin' do
      it { is_expected.to be_falsey }
    end
  end

  describe '#disable!' do
    subject { -> { dispatch_command(:disable, payload) }.call }

    let(:payload_text) { '/disable' }

    context 'when current user is admin' do
      before { stub_env('TELEGRAM_APP_OWNER_ID', current_user.external_id) }

      it { expect { subject }.to change { bot_setting.reload.enabled }.from(true).to(false) }
      it 'sends telegram message' do
        expect { subject }.to send_telegram_message(bot, 'Bot has been disabled', {
          chat_id: current_chat.external_id, reply_to_message_id: current_message.external_id
        })
      end
    end

    context 'when current user is not admin' do
      it { is_expected.to be_falsey }
    end
  end

  describe '#log_action' do
    subject { described_class.new(bot, payload).log_action(&block) }

    let(:payload_text) { 'Payload text' }
    let(:block) { -> { block_result } }
    let(:block_result) { 'Action block result' }

    context 'when controller logging is not allowed' do
      it { is_expected.to eq(block_result) }
    end

    context 'when controller logging is allowed' do
      let(:controller_logging) { true }

      it 'logs action' do
        expect_any_instance_of(described_class)
          .to receive_message_chain(:logger, :log_action)
          .with({
            app_name: 'ExampleApp',
            action_name: nil,
            block: block
          })
        subject
      end
    end
  end

  describe '#bot_enabled?' do
    subject { described_class.new(bot, payload).bot_enabled? }

    context 'when bot setting is enabled' do
      it { is_expected.to be_nil }
    end

    context 'when bot setting is not enabled' do
      let(:bot_setting_enabled) { false }

      it { expect { subject }.to raise_error(UncaughtThrowError) }
    end
  end

  describe '#sync_chat' do
    subject { described_class.new(bot, payload).sync_chat }

    let(:chat_params) { Hash[external_id: current_chat.external_id] }

    before do
      allow(Chat).to receive(:sync).and_return(:current_chat)
      allow(Telegram::AppManager::Builders::Chat).to receive(:build).with({ chat: payload.chat, bot_setting: bot_setting })
        .and_return(chat_params)
    end

    it 'calls Telegram::AppManager::Builders::Chat.build' do
      expect(Telegram::AppManager::Builders::Chat).to receive(:build).with({ chat: payload.chat, bot_setting: bot_setting })
      subject
    end

    it 'calls "report_new_chat" method' do
      expect_any_instance_of(described_class).to receive(:report_new_chat)
      subject
    end

    it 'calls Chat.sync' do
      expect(Chat).to receive(:sync).with(chat_params, { external_id: chat_params[:external_id] })
      subject
    end
  end

  describe '#sync_user' do
    subject { described_class.new(bot, payload).sync_user }

    let(:user_params) { Hash[external_id: current_user.external_id] }

    before do
      allow(User).to receive(:sync).and_return(:current_user)
      allow(Telegram::AppManager::Builders::User).to receive(:build).with({ user: payload.from }).and_return(user_params)
    end

    it 'calls Telegram::AppManager::Builders::User.build' do
      expect(Telegram::AppManager::Builders::User).to receive(:build).with({ user: payload.from })
      subject
    end

    it 'calls User.sync' do
      expect(User).to receive(:sync).with(user_params, { external_id: user_params[:external_id] })
      subject
    end
  end

  describe '#sync_chat_user' do
    subject { described_class.new(bot, payload).sync_chat_user }

    let(:chat_user_params) { Hash[chat_id: current_chat.id, user_id: current_user.id] }

    before do
      allow(ChatUser).to receive(:sync).and_return(current_chat_user)
      allow(Telegram::AppManager::Builders::ChatUser).to receive(:build).with({ chat: current_chat, user: current_user })
        .and_return(chat_user_params)
    end

    it 'calls Telegram::AppManager::Builders::ChatUser.build' do
      expect(Telegram::AppManager::Builders::ChatUser).to receive(:build).with({ chat: current_chat, user: current_user })
      subject
    end

    it 'calls ChatUser.sync' do
      expect(ChatUser).to receive(:sync).with(chat_user_params, { chat_id: current_chat.id, user_id: current_user.id })
      subject
    end
  end

  describe '#on_user_left_chat' do
    subject { described_class.new(bot, payload).on_user_left_chat }

    context 'when left_chat_member payload is not present' do
      it { is_expected.to be_nil }
    end

    context 'when left_chat_member payload is present' do
      let(:deleted_user) { create(:user) }
      let(:left_chat_member) do
        Telegram::Bot::Types::User.new(
          id: deleted_user.external_id,
          is_bot: deleted_user.is_bot?,
          first_name: deleted_user.first_name,
          last_name: deleted_user.last_name,
          username: deleted_user.username,
          language_code: 'en'
        )
      end

      context 'when chat user does not exist' do
        it { is_expected.to be_nil }
      end

      context 'when chat user exists' do
        let!(:chat_user) { create(:chat_user, deleted_at: nil, user: deleted_user, chat: current_chat) }

        it { expect { subject }.to change { chat_user.reload.deleted_at }.from(nil) }
      end
    end
  end

  describe '#sync_message' do
    subject { described_class.new(bot, payload).sync_message }

    context 'when message_id is blank' do
      before { allow_any_instance_of(described_class).to receive_message_chain(:payload, :message_id).and_return(nil) }

      it { is_expected.to be_nil }
    end

    context 'when message_id is not blank' do
      let(:message_params) { Hash[external_id: current_message.external_id] }

      before do
        allow(::Message).to receive(:sync).and_return(current_message)
        allow(Telegram::AppManager::Builders::Message).to receive(:build).with({ payload: payload, chat_user_id: current_chat_user.id })
          .and_return(message_params)
      end

      it 'calls Telegram::AppManager::Builders::Message.build' do
        expect(Telegram::AppManager::Builders::Message).to receive(:build).with({ payload: payload, chat_user_id: current_chat_user.id })
        subject
      end

      it 'calls Message.sync' do
        expect(Message).to receive(:sync).with(message_params, { external_id: message_params[:external_id] })
        subject
      end
    end
  end

  describe '#authenticate_chat!' do
    subject { described_class.new(bot, payload).authenticate_chat! }

    context 'when current chat is not approved' do
      let!(:current_chat) { create(:chat, approved: false) }

      it { expect { subject }.to raise_error(UncaughtThrowError) }
    end

    context 'when current chat is approved' do
      it { is_expected.to be_nil }
    end
  end

  describe '#authorize_admin!' do
    subject { described_class.new(bot, payload).authorize_admin! }

    context 'when current user is not admin' do
      it { expect { subject }.to raise_error(UncaughtThrowError) }
    end

    context 'when current user is admin' do
      before { stub_env('TELEGRAM_APP_OWNER_ID', current_user.external_id) }

      it { is_expected.to be_nil }
    end
  end

  describe 'private methods' do
    describe '#bot_setting' do
      subject { described_class.new(bot, payload).send(:bot_setting) }

      context 'when bot setting does not exist' do
        let!(:bot_setting) { nil }

        it { expect { subject }.to change(BotSetting, :count).by(1) }
        it { expect(subject.bot).to eq(bot.username) }
      end

      context 'when bot setting exists' do
        it { is_expected.to eq(bot_setting) }
      end
    end

    describe '#report_new_chat' do
      subject { described_class.new(bot, payload).send(:report_new_chat, chat_params) }

      context 'when chat does not exist' do
        let(:chat_params) { Hash[external_id: 123456789] }

        it 'calls Telegram::AppManager::Responders::NewChatRegistered.call' do
          expect_response(Telegram::AppManager::Responder::NewChatRegistered, chat: chat_params)
          subject
        end
      end

      context 'when chat exists' do
        let(:chat_params) { Hash[external_id: current_chat.external_id] }

        it { is_expected.to be_nil }
      end
    end
  end
end
