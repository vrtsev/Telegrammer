RSpec.describe PdrBot::Op::Reminder::BookTable do
  before do
    expect_any_instance_of(::Telegram::AppManager::Message).to receive(:send_to_chat)
  end
  
  let(:result) { described_class.call }

  it { expect(result.success?).to be_truthy }
  it { expect(I18n.t('.pdr_bot.reminders.book_table')).to include(result[:message]) }
end
