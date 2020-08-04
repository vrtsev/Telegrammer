require 'pry'
require 'rake'
require 'rake/testtask'
require 'dotenv'
require 'rspec/core/rake_task'

Dotenv.load('.env')

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation'
  # t.rspec_opts << ' more options'
end

task :default => :spec

namespace :redis do
  require 'redis'

  desc "Flush all redis data"
  task :flushall do
    REDIS = Redis.new(
      host:     ENV['REDIS_HOST'],
      port:     ENV['REDIS_PORT'],
      db:       ENV['REDIS_DB']
    )

    REDIS.ping
    REDIS.flushall
    puts 'Flushed all redis data'
  end
end

namespace :db do
  require 'sequel'
  Sequel.extension :migration

  DB_MIGRATIONS_PATH = 'db/migrations'
  DB_CONNECTION_PARAMS = {
    adapter: :postgres,
    user: ENV['POSTGRES_USER'],
    password: ENV['POSTGRES_PASSWORD'],
    host: ENV['POSTGRES_HOST'],
    port: ENV['POSTGRES_PORT'],
    database: ENV['POSTGRES_DB']
  }

  def current_schema_version(db_connection)
    if db_connection.tables.include?(:schema_info)
      db_connection[:schema_info].first[:version]
    end || 0
  end

  desc "Create database"
  task :create do
    Sequel.connect(DB_CONNECTION_PARAMS.merge(database: 'postgres'))
          .execute "CREATE DATABASE #{ENV['POSTGRES_DB']}"

    puts "Created database '#{ENV['POSTGRES_DB']}'"
    puts "Do not forger to run 'rake db:migrate' command"
  end

  desc "Create test database"
  task :prepare_for_test do
    test_database_name = ENV['POSTGRES_DB'] + '_test'
    connection = Sequel.connect(DB_CONNECTION_PARAMS.merge(database: 'postgres'))

    # DROP DB
    connection.execute "DROP DATABASE IF EXISTS #{test_database_name}"

    # CREATE DB
    connection.execute "CREATE DATABASE #{test_database_name}"

    # MIGRATE DB
    Sequel::Migrator.run(
      Sequel.connect(DB_CONNECTION_PARAMS.merge(database: test_database_name)),
      DB_MIGRATIONS_PATH
    )

    puts "Prepared DB for test environment"
  end

  desc "Drop database with all data"
  task :drop do
    Sequel.connect(DB_CONNECTION_PARAMS.merge(database: 'postgres'))
          .execute "DROP DATABASE IF EXISTS #{ENV['POSTGRES_DB']}"

    puts "Dropped database '#{ENV['POSTGRES_DB']}'"
  end

  desc "Prints current schema version"
  task :version do
    DB = Sequel.connect(DB_CONNECTION_PARAMS)
    puts "Schema Version: #{current_schema_version(DB)}"
  end

  desc "Perform migration up to latest migration available"
  task :migrate do
    DB = Sequel.connect(DB_CONNECTION_PARAMS)
    Sequel::Migrator.run(DB, DB_MIGRATIONS_PATH)
    puts "Migrated. Schema Version: #{current_schema_version(DB)}"
  end

  desc "Perform rollback to specified target or full rollback as default"
  task :rollback do |t|
    DB = Sequel.connect(DB_CONNECTION_PARAMS)
    version = current_schema_version(DB)
    return puts 'Your DB does not contain any migrations' if version.zero?

    Sequel::Migrator.run(DB, DB_MIGRATIONS_PATH, target: version - 1)
    puts "Rolled back. Schema Version: #{current_schema_version(DB)}"
  end

  desc "Perform database reset (drop shema with all tables and data)"
  task :clear do
    DB = Sequel.connect(DB_CONNECTION_PARAMS)
    DB.execute "DROP SCHEMA public CASCADE;"
    DB.execute "CREATE SCHEMA public;"
    puts "DB clear. Schema Version: #{current_schema_version(DB)}"
  end

  desc "Seed database with example test data"
  task :seed do
    require './config/boot.rb'
    require './db/seed.rb'
    puts "DB seed completed"
  end
end
