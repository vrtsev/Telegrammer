# frozen_string_literal: false

FactoryBot.define do
  factory :pdr_game_stat, class: PdrGame::Stat do
    association :chat_user

    loser_count { 0 }
    winner_count { 0 }
  end
end
