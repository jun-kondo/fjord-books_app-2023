# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    sequence(:name) { |n| "user_#{n}" }
    postal_code { '1234567' }
    address { Faker::Address.full_address }
    self_introduction { Faker::Lorem.paragraph }
  end
end
