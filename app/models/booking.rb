class Booking < ApplicationRecord
  # after_create :update_workshop_sit_count
  belongs_to :customer
  belongs_to :workshop

  validate :sufficient_sits_available  # Custom validation

  private

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