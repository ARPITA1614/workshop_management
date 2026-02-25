FactoryBot.define do
  factory :workshop do
    name { "Rails Workshop" }
    description { "Learn Ruby on Rails from basics to advanced." }

    start_date { Date.today + 1.day }
    end_date { Date.today + 2.days }

    start_time { "10:00 AM" }
    end_time { "04:00 PM" }

    total_sits { 50 }

    registration_fee { 999 } # if exists
    remaining_sits { 50 } 
  end
end
