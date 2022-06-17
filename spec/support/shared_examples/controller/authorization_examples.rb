RSpec.shared_examples 'controller/authorization_examples' do
  describe 'authorization module' do
    before do
      allow_any_instance_of(described_class).to receive(:current_chat).and_return(current_chat)
      allow_any_instance_of(described_class).to receive(:current_message).and_return(current_message)
      allow_any_instance_of(described_class).to receive(:throw)
    end

    describe '#authorize_chat' do
      subject { described_class.new(bot.client, base_payload).authorize_chat }

      context 'when chat is approved' do
        it { is_expected.to be_truthy }
      end

      context 'when chat is not approved' do
        let(:is_chat_approved) { false }
        let(:reply_message_params) do
          {
            bot_id: bot.id,
            chat_id: current_chat.id,
            text: 'This chat is not approved to use this bot',
            message_id: current_message.id
          }
        end

        it { expect_service_call(Messages::Reply, reply_message_params) }
        it { expect_any_instance_of(described_class).to receive(:throw).with(:abort); subject }
      end
    end

    describe '#authorize_admin' do
      subject { described_class.new(bot.client, base_payload).authorize_admin }

      let(:external_id) { 123456 }
      let(:user) { create(:user, external_id: external_id) }

      before { allow_any_instance_of(described_class).to receive(:current_user).and_return(user) }

      context 'when user is admin' do
        before { stub_env('TELEGRAM_APP_OWNER_ID', external_id) }

        it { is_expected.to be_truthy }
      end

      context 'when user is not admin' do
        let(:reply_message_params) do
          {
            bot_id: bot.id,
            chat_id: current_chat.id,
            text: 'You do not have enough rights to perform this action',
            message_id: current_message.id
          }
        end

        it { expect_service_call(Messages::Reply, reply_message_params) }
        it { expect_any_instance_of(described_class).to receive(:throw).with(:abort); subject }
      end
    end
  end
end
