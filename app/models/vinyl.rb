class Vinyl < ApplicationRecord
  has_many :offers
  validates :name, presence: true
  validates :artist, presence: true
end
