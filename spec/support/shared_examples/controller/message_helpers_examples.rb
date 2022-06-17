RSpec.shared_examples 'controller/message_helpers_examples' do
  before do
    allow_service_call(Messages::Create)
    allow_service_call(Messages::Reply)
    allow_service_call(Messages::Edit)
    allow_service_call(Messages::Delete)
  end

  describe 'message helpers module' do
    before { allow_any_instance_of(described_class).to receive(:current_message).and_return(current_message) }

    describe '#send_message' do
      subject { described_class.new(bot.client, base_payload).send_message(params) }

      let(:params) { Hash[text: 'Message text'] }

      it 'calls service' do
        expect(Messages::Create).to receive(:call).with({ bot_id: bot.id, chat_id: nil, **params }).once
        subject
      end
    end

    describe '#reply_message' do
      subject { described_class.new(bot.client, base_payload).reply_message(params) }

      let(:params) { Hash[text: 'Reply text'] }

      it 'calls service' do
        expect(Messages::Reply).to receive(:call).with({
          bot_id: bot.id,
          chat_id: nil,
          message_id: current_message.id,
          **params
        }).once

        subject
      end
    end

    describe '#edit_message' do
      subject { described_class.new(bot.client, base_payload).edit_message(params) }

      let(:params) { Hash[text: 'Updated text'] }

      it 'calls service' do
        expect(Messages::Edit).to receive(:call).with({
          bot_id: bot.id,
          chat_id: nil,
          message_id: current_message.id,
          **params
        }).once

        subject
      end
    end

    describe '#delete_message' do
      subject { described_class.new(bot.client, base_payload).delete_message(params) }

      let(:params) { Hash[] }

      it 'calls service' do
        expect(Messages::Delete).to receive(:call).with({
          bot_id: bot.id,
          chat_id: nil,
          message_id: current_message.id,
          **params
        }).once

        subject
      end
    end
  end
end
