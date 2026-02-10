class Booking < ApplicationRecord
  after_create :update_workshop_sit_count
  belongs_to :customer
  belongs_to :workshop

  def update_workshop_sit_count
    # decrement! is more reliable than manual math
    workshop.decrement!(:remaining_sits, no_of_tickets)
  end
end