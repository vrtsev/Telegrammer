# frozen_string_literal: true

module PdrBot
  class GameStat < Sequel::Model(:pdr_bot_game_stats)
    class Counters
      include Ruby::Enum

      define :winner, :winner_count
      define :loser, :loser_count
    end
  end
end
