RSpec.shared_examples 'controller/bot_state_examples' do
  let(:bot_name) { raise "implement 'let(:bot_name)' variable in your specs" }
  let!(:bot) { create(:bot, name: bot_name, username: bot_name, enabled: is_bot_enabled, autoapprove_chat: is_autoapprove_chat) }
  let(:is_bot_enabled) { true }
  let(:is_autoapprove_chat) { true }

  before { allow_any_instance_of(described_class).to receive(:bot).and_return(bot) }

  describe 'bot state module' do
    before { allow_any_instance_of(described_class).to receive(:authorize_admin).and_return(true) }

    describe '#enable!' do
      subject { -> { dispatch_command(:enable, base_payload) }.call }

      let(:is_bot_enabled) { false }

      it { expect { subject }.to change { bot.reload.enabled }.from(false).to(true) }
      it { expect_sent_message(text: 'Bot has been enabled', chat_id: app_owner_chat.id) }
    end

    describe '#disable!' do
      subject { -> { dispatch_command(:disable, base_payload) }.call }

      let(:is_bot_enabled) { true }

      it { expect { subject }.to change { bot.reload.enabled }.from(true).to(false) }
      it { expect_sent_message(text: 'Bot has been disabled', chat_id: app_owner_chat.id) }
    end

    describe '#check_bot_state' do
      subject { described_class.new(bot, base_payload).check_bot_state }

      context 'when bot is enabled' do
        let(:is_bot_enabled) { true }

        it { is_expected.to be_truthy }
      end

      context 'when bot is disabled' do
        let(:is_bot_enabled) { false }

        it { expect { subject }.to raise_error(UncaughtThrowError) }
      end
    end
  end
end
