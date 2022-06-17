# frozen_string_literal: true

RSpec.describe ChatUsers::Sync do
  subject { described_class.call(params) }

  let(:chat) { create(:chat) }
  let(:user) { create(:user) }
  let(:deleted) { false }
  let(:params) do
    {
      chat_id: chat.id,
      user_id: user.id,
      deleted: deleted
    }
  end

  it { expect(subject.success?).to be_truthy }

  context 'when chat user does not exist' do
    it { expect { subject }.to change(ChatUser, :count).by(1) }

    it 'sets proper attributes' do
      expect(subject.chat_user).to have_attributes(
        chat_id: chat.id,
        user_id: user.id,
        deleted_at: nil
      )
    end
  end

  context 'when chat user exists' do
    let!(:chat_user) { create(:chat_user, user_id: user.id, chat_id: chat.id) }

    it { expect { subject }.not_to change(ChatUser, :count) }

    context 'when deleted param is true' do
      let(:deleted) { true }

      it 'sets deleted_at attribute' do
        Timecop.freeze(Time.now) do
          expect(subject.chat_user).to have_attributes(deleted_at: Time.now)
        end
      end
    end

    context 'when deleted param is false' do
      it { expect(subject.chat_user).to have_attributes(deleted_at: nil) }
    end
  end
end
