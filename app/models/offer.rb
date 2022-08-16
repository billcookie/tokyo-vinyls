class Offer < ApplicationRecord
  belongs_to :vinyl
  belongs_to :user

  has_many :bookings

  validates :description, length: { in: 8..250 }
  validates :price, numericality: { only_integer: true }
  validates :location, presence: true

end
