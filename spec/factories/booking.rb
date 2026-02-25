FactoryBot.define do
  factory :booking do
    association :customer
    association :workshop
    stripe_transaction_id { "ch_test_123" }
    amount_paid { 2000 }
     no_of_tickets { 2 }
  end
end