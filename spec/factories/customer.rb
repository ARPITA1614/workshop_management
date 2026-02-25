FactoryBot.define do
  factory :customer do
    sequence(:email) { |n| "customer#{n}@example.com" }

    password { "password123" }
    password_confirmation { "password123" }

    contact_number { "9876543210" }

    full_name { "Test Customer" } # if required
  end
end
