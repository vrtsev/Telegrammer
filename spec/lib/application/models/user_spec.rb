# frozen_string_literal: true

RSpec.describe User, type: :model do
  context 'validations' do
    subject { create(:user) }

    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_uniqueness_of(:external_id) }
  end

  describe '#name' do
    subject { user.name }

    let(:user) { create(:user, username: username, first_name: first_name, last_name: last_name) }
    let(:username) { nil }
    let(:first_name) { nil }
    let(:last_name) { nil }


    context 'when user has first_name or last_name' do
      context 'when user has only first_name' do
        let(:first_name) { Faker::Name.first_name }

        it { is_expected.to eq(first_name) }
      end

      context 'when user has only last_name' do
        let(:last_name) { Faker::Name.last_name }

        it { is_expected.to eq(last_name) }
      end
    end

    context 'when user does not have first_name and last_name' do
      let(:username) { Faker::Internet.username }

      it { is_expected.to eq("@#{username}") }
    end
  end
end
