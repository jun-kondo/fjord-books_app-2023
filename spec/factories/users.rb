# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    trait :attached_png do
      image do
        Rack::Test::UploadedFile.new( \
          Rails.root.join('spec/factories/sample.png').to_s
        )
      end
    end

    trait :attached_jpg do
      image do
        Rack::Test::UploadedFile.new( \
          Rails.root.join('spec/factories/sample.jpg').to_s
        )
      end
    end

    trait :attached_gif do
      image do
        Rack::Test::UploadedFile.new( \
          Rails.root.join('spec/factories/sample.gif').to_s
        )
      end
    end
  end
end
