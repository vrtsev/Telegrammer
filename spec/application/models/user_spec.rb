# frozen_string_literal: true

RSpec.describe User, type: :model do
  it_behaves_like 'synchronizable model' do
    let(:init_attrs) { Hash[external_id: Faker::Number.number(digits: 8)] }
  end

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

    context 'when user has username' do
      let(:username) { Faker::Internet.username }

      it { is_expected.to eq("@#{username}") }
    end

    context 'when user does not have username' do
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