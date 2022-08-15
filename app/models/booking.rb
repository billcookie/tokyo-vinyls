class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :offer

  validates :start_date, presence: true
  validates :end_date, presence: true

  enum status: [ :pending, :accepted, :rejected ]
end
