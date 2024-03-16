# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    memo { Faker::Book.genre }
    author { Faker::Book.author }
  end
end
