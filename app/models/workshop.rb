class Workshop < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
   has_many :bookings, dependent: :destroy
  has_many :customers, through: :bookings
  has_one_attached :image

  validates :name, :description, presence: true
  validates :start_date, :end_date, :start_time, :end_time, presence: true
  validates :total_sits, :registration_fee, presence: true, numericality: true
  validates :end_date, comparison: { greater_than: :start_date, message: "cannot be before start date" }

  scope :upcoming_workshops, -> { where('start_date > ?', Date.today) }
  scope :past_workshops, -> { where('end_date < ?', Date.today) }
  
  # def self.upcoming_workshops
  #   where('start_date > ?', Date.today)
  # end

  def total_duration
    "From #{start_date} to #{end_date}"
  end

  def daily_workshop_hours
    "#{((start_time.to_time - end_time.to_time)/1.hours).abs} hours"
  end

  def daily_duration
    "Everyday #{start_time} to #{end_time} (#{daily_workshop_hours})"
  end

  def is_upcoming_workshop?
    start_date > Date.today
  end

  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "end_date", "end_time", "id", "id_value", "name", "registration_fee", "remaining_sits", "slug", "start_date", "start_time", "total_sits", "updated_at"]
  end

   def self.ransackable_associations(auth_object = nil)
    ["bookings", "customers"]
  end
end

# one to many btw customers and booking
# one to many btw workshops and booking
# many to many cutomers and workshops
