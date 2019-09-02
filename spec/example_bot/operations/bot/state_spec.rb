RSpec.describe ExampleBot::Op::Bot::State do
  let(:result) { described_class.call }

  context 'when state not found' do
    it 'returns default bot state' do
      REDIS.del("#{ExampleBot.bot.username}:state")
      state = REDIS.get("#{ExampleBot.bot.username}:state")

      expect(state).to be_nil
      expect(result[:enabled]).to eq(described_class::DEFAULT_BOT_STATE)
    end
  end

  context 'when state present' do
    context 'when bot is enabled' do
      it 'returns true state' do
        REDIS.set("#{ExampleBot.bot.username}:state", true)
        expect(result[:enabled]).to be_truthy
      end
    end

    context 'when bot is disabled' do
      it 'returns false state' do
        REDIS.set("#{ExampleBot.bot.username}:state", false)
        expect(result[:enabled]).to be_falsey
      end
    end
  end
end

