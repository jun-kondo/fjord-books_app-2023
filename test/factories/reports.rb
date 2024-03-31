# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph }
    association :user
  end
end
