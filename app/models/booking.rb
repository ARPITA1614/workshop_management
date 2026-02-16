class Booking < ApplicationRecord
 
  # after_create :update_workshop_sit_count
  has_many :refunds
  belongs_to :customer
  belongs_to :workshop

  validate :sufficient_sits_available  # Custom validation
  validates :order_number, presence: true, uniqueness: true

  before_validation :generate_order_number

  def is_refundable?
    workshop.start_date > Date.today
  end

  


  def self.ransackable_associations(auth_object = nil)
    ["bookings", "customer", "refunds", "workshop"]
  end

  # 🔥 Allow ransack attributes
 def self.ransackable_attributes(auth_object = nil)
  [
    "id",
    "created_at",
    "updated_at",
    "customer_id",
    "workshop_id",
    "order_number",
      "amount_paid"     # 🔥 ADD THIS
  ]
end

  private

  def generate_order_number
    self.order_number="BOOKING-#{SecureRandom.hex(5).upcase}"
  end

  def sufficient_sits_available
    if workshop.remaining_sits < no_of_tickets
      errors.add(:no_of_tickets, "Not enough sits available")
    end
  end

  def update_workshop_sit_count
    # Subtract from current remaining_sits (not total_sits)
    new_remaining = workshop.remaining_sits - no_of_tickets
    workshop.update!(remaining_sits: new_remaining)
    Rails.logger.info "Updated remaining_sits to #{new_remaining}"  # Debug log
  end


  
end