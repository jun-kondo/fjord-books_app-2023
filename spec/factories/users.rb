# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    trait :attached_png do
      image do
        Rack::Test::UploadedFile.new( \
        "#{Rails.root}/spec/factories/sample.png")
      end
    end

    trait :attached_jpeg do
      image do
        Rack::Test::UploadedFile.new( \
          "#{Rails.root}/spec/factories/sample.jpeg")
      end
    end

    trait :attached_gif do
      image do
        Rack::Test::UploadedFile.new( \
          "#{Rails.root}/spec/factories/sample.gif")
      end
    end
  end
end
