module PdrBot
  class Stat < Sequel::Model(:pdr_bot_stats)

    class Counters
      include Ruby::Enum

      define :winner, :winner_count
      define :loser, :loser_count
    end

  end
end
