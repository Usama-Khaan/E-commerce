FactoryBot.define do
  factory :order do
    email { 'test@example.com' }
    country { 'United States' }
    first_name { 'John' }
    last_name { 'Doe' }
    address { '123 Main Street' }
    city { 'Anytown' }
    postal_code { '12345' }
    phone_number { '555-555-5555' }
    status { 'pending' }

    association :user
    association :cart
  end
end
