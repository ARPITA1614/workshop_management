class Customer < ApplicationRecord
  has_many :bookings
  has_many :workshops, through: :bookings
  has_many :refunds

  validates :full_name, :contact_number, presence: true
  validates :email, presence: true, uniqueness: true

    def self.ransackable_attributes(auth_object = nil)
    column_names - [
      "encrypted_password",
      "reset_password_token",
      "confirmation_token"
    ]
  end

  # 🔥 Allow searchable associations
  def self.ransackable_associations(auth_object = nil)
    ["bookings", "refunds", "workshops"]
  end

end

# error hold execution of program undefined variable syntax error valid id in development mode 
# bugs not hold of program but unexpected outcome stax correct caught at testing requirement gathering ex:- avoid customer to ask refund for past workshops