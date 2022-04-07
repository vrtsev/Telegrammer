# frozen_string_literal: false

require 'pry'
require 'rake'
require 'rake/testtask'
require 'dotenv'
require 'rspec/core/rake_task'
require 'standalone_migrations'
require './config/boot.rb'

StandaloneMigrations::Tasks.load_tasks

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation'
  # t.rspec_opts << ' more options'
end

task default: :spec

namespace :redis do
  desc 'Flush all redis data'
  task :flushall do
    REDIS.ping
    REDIS.flushall
    puts 'Flushed all redis data'
  end
end

namespace :bots do
  desc 'Set disabled state for each bot'
  task :disable_all do
    BotSetting.update_all(enabled: false)
  end
end

namespace :translations do
  desc 'Check if all translations is imported to DB'
  task :check do
    absent_keys = Translation::TRANSLATION_KEYS.map do |translation_key|
      translation_key unless Translation.exists?(chat_id: nil, key: translation_key)
    end.compact

    raise "Translations not found for keys: #{absent_keys}" if absent_keys.any?
    puts 'Check is completed'
  end
end
