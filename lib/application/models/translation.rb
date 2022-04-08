# frozen_string_literal: true

class Translation < ActiveRecord::Base
  TRANSLATION_KEYS = %w[
    example_bot.command_exception
    example_bot.auto_response
    example_bot.start_message
    jenia_bot.command_exception
    jenia_bot.default_call_answer
    jenia_bot.start_message
    pdr_bot.command_exception
    pdr_bot.start_message
    pdr_bot.game.start.title
    pdr_bot.game.start.searching_users
    pdr_bot.game.reminder
    pdr_bot.game.errors.latest_round_not_expired
    pdr_bot.game.errors.not_enough_users
    pdr_bot.game.errors.stats_not_found
    pdr_bot.game.errors.no_rounds
    pdr_bot.game.results.title
    pdr_bot.game.results.loser
    pdr_bot.game.results.winner
    pdr_bot.game.stats.leaders.title
    pdr_bot.game.stats.leaders.winner
    pdr_bot.game.stats.leaders.loser
    pdr_bot.game.stats.chat_user_stat
  ].freeze

  belongs_to :chat

  validates :key, presence: true, uniqueness: { scope: :chat_id }

  def self.for(key, **params)
    raise "key is not registered: #{key}" unless TRANSLATION_KEYS.include?(key)

    translation = where(chat_id: params[:chat_id])
      .or(where(chat_id: nil))
      .order(:chat_id)
      .find_by!(key: key)

    translation.interpolate(params)
  end

  def interpolate(args)
    values.sample % args
  end
end
