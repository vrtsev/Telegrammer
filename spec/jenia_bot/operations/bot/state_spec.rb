# frozen_string_literal: false

RSpec.describe JeniaBot::Op::Bot::State do
  let(:result) { described_class.call }

  context 'when state not found' do
    it 'returns default bot state' do
      allow(ENV).to receive(:[]).with('JENIA_BOT_DEFAULT_STATE').and_return('true')

      REDIS.del("#{::Telegram.bots[:jenia_bot].username}:state")
      state = REDIS.get("#{::Telegram.bots[:jenia_bot].username}:state")

      expect(state).to be_nil
      expect(result[:enabled]).to eq(JSON.parse(ENV['JENIA_BOT_DEFAULT_STATE']))
    end
  end

  context 'when state present' do
    context 'when bot is enabled' do
      it 'returns true state' do
        REDIS.set("#{::Telegram.bots[:jenia_bot].username}:state", true)
        expect(result[:enabled]).to be_truthy
      end
    end

    context 'when bot is disabled' do
      it 'returns false state' do
        REDIS.set("#{::Telegram.bots[:jenia_bot].username}:state", false)
        expect(result[:enabled]).to be_falsey
      end
    end
  end
end
