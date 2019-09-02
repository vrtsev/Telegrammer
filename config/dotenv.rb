example_env_file = File.open '.env.example'

Dotenv.load(File.open ENV_FILE_NAME)
puts 'Loaded all env vars from ' + ENV_FILE_NAME.to_s.bold.cyan

env_keys = Dotenv.parse(example_env_file).keys
Dotenv.require_keys(env_keys)