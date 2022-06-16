# frozen_string_literal: true

RSpec.describe Users::Sync do
  subject { described_class.call(bot_id: bot.id, payload: payload) }

  let(:stubbed_user) { double(User, id: 1, name: 'Stubbed user', is_bot?: false) }
  let(:bot) { create(:bot, name: 'example_bot', username: 'example_bot') }
  let(:payload) do
    {
      id: 12345678,
      username: 'username',
      first_name: 'First name',
      last_name: 'Last name',
      is_bot: false
    }
  end

  before { allow(User).to receive(:sync_by!).and_return(stubbed_user) }

  it { expect(subject.success?).to be_truthy }

  it 'calls sync_by! on User model' do
    expect(User).to receive(:sync_by!).with(:external_id, {
      external_id: 12345678,
      username: 'username',
      first_name: 'First name',
      last_name: 'Last name',
      is_bot: false,
      bot_id: bot.id
    }).once

    subject
  end
end
