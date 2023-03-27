# frozen_string_literal: true

RSpec.shared_context 'bot_helpers' do
  before do
    allow_any_instance_of(Telegram::AppManager::Client).to receive(:request).and_return(true)
  end
end
