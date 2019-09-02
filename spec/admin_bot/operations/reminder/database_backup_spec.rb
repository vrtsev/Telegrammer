RSpec.describe AdminBot::Op::Reminder::DatabaseBackup do
  before do
    expect_any_instance_of(::Telegram::BotManager::Message).to receive(:send_to_app_owner)
  end

  let(:result) { described_class.call }

  it { expect(result.success?).to be_truthy }
  it { expect(AdminBot.localizer.samples('reminder.database_backup.message')).to include(result[:message]) }
end
