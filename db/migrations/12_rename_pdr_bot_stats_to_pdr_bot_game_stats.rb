# frozen_string_literal: true

Sequel.migration do
  up do
    rename_table :pdr_bot_stats, :pdr_bot_game_stats
  end

  down do
    rename_table :pdr_bot_game_stats, :pdr_bot_stats
  end
end
