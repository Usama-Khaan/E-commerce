FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@gmail.com" }
    password { 'nasreen@' }
    username { 'nasreen' }
  end
end
