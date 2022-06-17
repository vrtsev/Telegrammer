RSpec.shared_examples 'controller/events_examples' do
  describe 'events module' do
    describe '#perform_events' do
      subject { controller_instance.perform_events }

      let(:controller_instance) { described_class.new(bot, base_payload) }

      before do
        allow_any_instance_of(described_class).to receive(:payload).and_return(payload)
        allow_any_instance_of(described_class).to receive(:current_chat).and_return(current_chat)
        allow(Users::Sync).to receive(:call).and_return instance_double(Users::Sync, user: event_user)
      end

      context 'when payload contains new chat members' do
        let(:event_user) { instance_double(User, id: 1) }
        let(:payload) { base_payload.merge('new_chat_members' => [{ 'id' => event_user.id }]) }

        it { expect { subject }.to change { controller_instance.new_chat_members }.from(nil).to([event_user]) }
        it { expect_service_call(Users::Sync, bot_id: nil, payload: payload['new_chat_members'].first) }
        it { expect_service_call(ChatUsers::Sync, chat_id: current_chat.id, user_id: event_user.id, deleted: false) }
      end

      context 'when payload contains left chat member' do
        let(:event_user) { instance_double(User, id: 1) }
        let(:payload) { Hash['left_chat_member' => { 'id' => event_user.id }] }

        it { expect { subject }.to change { controller_instance.left_chat_member }.from(nil).to(event_user) }
        it { expect_service_call(Users::Sync, bot_id: nil, payload: payload['left_chat_member']) }
        it { expect_service_call(ChatUsers::Sync, chat_id: current_chat.id, user_id: event_user.id, deleted: true) }
      end
    end
  end
end
