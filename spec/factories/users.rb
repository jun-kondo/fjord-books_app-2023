FactoryBot.define do
  factory :user do
    email { 'tester@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    zip_code { 1008111 }
    address { '東京都千代田区1-1-1' }
    self_introduction { 'ごきげんよう' }
  end
end
