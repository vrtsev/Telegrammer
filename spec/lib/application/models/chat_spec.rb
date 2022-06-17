# frozen_string_literal: true

RSpec.describe Chat, type: :model do
  context 'validations' do
    subject { create(:chat) }

    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_presence_of(:chat_type) }
    it { is_expected.to validate_uniqueness_of(:external_id) }
  end

  describe '.for_app_owner' do
    subject { described_class.for_app_owner }

    let(:external_id) { 123456 }

    before { stub_env('TELEGRAM_APP_OWNER_ID', external_id) }

    context 'when app owner chat exists' do
      let!(:app_owner_chat) do
        create(:chat, external_id: external_id,
                      chat_type: Chat.chat_types[:private_chat],
                      approved: true)
      end

      it { is_expected.to eq(app_owner_chat) }
    end

    context 'when app owner chat does not exist' do
      it { expect { subject }.to change(Chat, :count).by(1) }
      it { expect(subject.external_id).to eq(external_id) }
    end
  end

  describe '#name' do
    subject { chat.name }

    let(:chat) { create(:chat, title: title, username: username, first_name: first_name, last_name: last_name) }
    let(:title) { nil }
    let(:username) { nil }
    let(:first_name) { nil }
    let(:last_name) { nil }

    context 'when chat has title' do
      let(:title) { Faker::Internet.username }

      it { is_expected.to eq(title) }
    end

    context 'when chat does not have title' do
      context 'but has first_name or last_name' do
        context 'and only first_name' do
          let(:first_name) { Faker::Name.first_name }

          it { is_expected.to eq(first_name) }
        end

        context 'and only last_name' do
          let(:last_name) { Faker::Name.last_name }

          it { is_expected.to eq(last_name) }
        end

        context 'and has both' do
          let(:first_name) { Faker::Name.first_name }
          let(:last_name) { Faker::Name.last_name }

          it { is_expected.to eq("#{first_name} #{last_name}") }
        end
      end

      context 'and does not have first_name and last_name' do
        let(:username) { Faker::Internet.username }

        it { is_expected.to eq(username) }
      end
    end
  end
end
