class Vinyl < ApplicationRecord
  belongs_to :artist
  has_many :offers

  validates :name, presence: true
  validates :artist, presence: true
end
