# frozen_string_literal: false

require './config/boot'
require 'sidekiq/testing'
require 'telegram/bot/rspec/integration/poller'
require './db/seeds/translations'
require_all 'spec/support'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :active_model
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.include_context 'controller_helpers', type: :controller

  config.before(:suite) do
    Sidekiq::Testing.inline!
    Telegram::Bot::ClientStub.stub_all!
    Telegram::AppManager.config.controller_action_logging = false
    REDIS = MockRedis.new
    ActiveRecord::Base.logger.level = :error
    DatabaseCleaner[:active_record].strategy = DatabaseCleaner::ActiveRecord::Deletion.new(except: ['translations'])
    FactoryBot.find_definitions
  end

  config.after(:each) do
    Sidekiq::Worker.clear_all
  end

  config.around(:each) do |example|
    DatabaseCleaner[:active_record].cleaning do
      example.run
    end
  end

  def stub_env(env_key, return_value)
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with(env_key).and_return(return_value)
  end
end
