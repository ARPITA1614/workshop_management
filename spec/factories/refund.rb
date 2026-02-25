FactoryBot.define do
  factory :refund do
    association :customer
    association :booking
    state { "accepted" }
    no_of_tickets { 1 }
    amount_refunded { 1000 }
  end
end