# frozen_string_literal: true

RSpec.describe Telegram::AppManager::Responder do
  let(:context) { nil }
  let(:bot) { Telegram.bots[:example_bot] }
  let(:params) { Hash[key: :value] }

  describe '.call' do
    subject { described_class.call(context: context, bot: bot, params: params) }

    before do
      allow_any_instance_of(described_class).to receive(:validate)
      allow_any_instance_of(described_class).to receive(:call)
    end

    it 'has proper instance variables values' do
      expect(subject.context).to eq(context)
      expect(subject.bot).to eq(bot)
      expect(subject.params).to eq(params)
    end

    it 'calls instance method "validate"' do
      expect_any_instance_of(described_class).to receive(:validate)
      subject
    end

    it 'calls instance method "call"' do
      expect_any_instance_of(described_class).to receive(:call)
      subject
    end
  end

  describe 'private methods' do
    let(:instance) { described_class.new(context: context, bot: bot, params: params) }
    let(:type) { :message }
    let(:options) { Hash[] }
    let(:method_name) { "send_#{type}" }

    describe '#respond_with' do
      subject { instance.send(:respond_with, type, options) }

      let(:current_chat) { create(:chat) }

      before do
        allow_any_instance_of(described_class).to receive(:call).and_return(nil)
        allow_any_instance_of(described_class).to receive(:current_chat).and_return(current_chat)
      end

      context 'when chat_id param is not present' do
        it 'calls method on bot with current chat external_id' do
          expect(bot).to receive(method_name).with({ chat_id: current_chat.external_id })
          subject
        end
      end

      context 'when chat_id param is present' do
        let(:options) { Hash[chat_id: chat_id] }
        let(:chat_id) { 12345 }

        it 'calls method on bot with passed chat id' do
          expect(bot).to receive(method_name).with({ chat_id: chat_id })
          subject
        end
      end

      context 'when delay param is present' do
        let(:options) { Hash[delay: delay_seconds] }
        let(:delay_seconds) { 3 }

        before { allow_any_instance_of(described_class).to receive(:sleep) }

        it do
          expect_any_instance_of(described_class).to receive(:sleep).with(delay_seconds)
          subject
        end

        it do
          expect(bot).to receive(method_name).with({ chat_id: current_chat.external_id, delay: delay_seconds })
          subject
        end
      end
    end

    describe '#reply_with' do
      subject { instance.send(:reply_with, type, options) }

      let(:current_message) { create(:message) }

      before do
        allow_any_instance_of(described_class).to receive(:call).and_return(nil)
        allow_any_instance_of(described_class).to receive(:current_message).and_return(current_message)
      end

      context 'when "reply_to_message_id" param is not present' do
        it 'calls "respond_with" method' do
          expect_any_instance_of(described_class).to receive(:respond_with).with(type, { reply_to_message_id: current_message.external_id })
          subject
        end
      end

      context 'when "reply_to_message_id" param is present' do
        let(:options) { Hash[reply_to_message_id: message_id] }
        let(:message_id) { 12345 }

        it 'calls "respond_with" method' do
          expect_any_instance_of(described_class).to receive(:respond_with).with(type, { reply_to_message_id: message_id })
          subject
        end
      end
    end
  end
end
