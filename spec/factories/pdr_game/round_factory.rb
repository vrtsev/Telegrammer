# frozen_string_literal: false

FactoryBot.define do
  factory :pdr_game_round, class: PdrGame::Round do
    association :chat
    association :initiator, factory: :user
    association :loser, factory: :user
    association :winner, factory: :user
  end
end
