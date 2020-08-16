# frozen_string_literal: true

Dotenv.load(File.open(ENV_FILE_NAME))

# Validate current env file keys with example env file
EXAMPLE_ENV_FILE_NAME = '.env.example'
env_keys = Dotenv.parse(File.open(EXAMPLE_ENV_FILE_NAME)).keys
Dotenv.require_keys(env_keys)

puts 'Loaded all env vars from ' + ENV_FILE_NAME.to_s.bold.cyan
