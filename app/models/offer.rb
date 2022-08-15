class Offer < ApplicationRecord
  belongs_to :vinyl
  belongs_to :user

  has_many :bookings
end
