# frozen_string_literal: false

FactoryBot.define do
  factory :jenia_question do
    association :chat

    text { Faker::Lorem.sentence }
  end
end
