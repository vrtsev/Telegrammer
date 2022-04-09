# frozen_string_literal: true

RSpec.describe Chat, type: :model do
  it_behaves_like 'synchronizable model' do
    let(:init_attrs) { Hash[external_id: Faker::Number.number(digits: 8)] }
  end

  context 'validations' do
    subject { create(:chat) }

    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_presence_of(:chat_type) }
    it { is_expected.to validate_uniqueness_of(:external_id) }
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
      context 'but has username' do
        let(:username) { Faker::Internet.username }

        it { is_expected.to eq(username) }
      end

      context 'and does not have username' do
        context 'but has first name' do
          let(:first_name) { Faker::Name.first_name }

          it { is_expected.to eq(first_name) }
        end

        context 'but has last name' do
          let(:last_name) { Faker::Name.last_name }

          it { is_expected.to eq(last_name) }
        end

        context 'but has both first and last name' do
          let(:first_name) { Faker::Name.first_name }
          let(:last_name) { Faker::Name.last_name }

          it { is_expected.to eq("#{first_name} #{last_name}") }
        end
      end
    end
  end

  describe '#pdr_game_round' do
    subject { chat.pdr_game_round }

    let(:chat) { create(:chat) }

    context 'when round exists' do
      let!(:pdr_game_round) { create(:pdr_game_round, chat: chat) }

      it { is_expected.to eq(pdr_game_round) }
    end

    context 'when round does not exist' do
      it { is_expected.to be_kind_of(PdrGame::Round) }
    end
  end
end