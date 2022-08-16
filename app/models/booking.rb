class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :offer

  validates :start_date, presence: true
  validates :end_date, comparison: { greater_than_or_equal_to: start_date }

  enum status: [ :pending, :accepted, :rejected ]
end
