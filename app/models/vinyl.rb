class Vinyl < ApplicationRecord
  belongs_to :artist
  has_many :offers, dependent: :destroy
  validates :name, presence: true
  validates :artist, presence: true
  accepts_nested_attributes_for :artist

  include PgSearch::Model
  pg_search_scope :song_artist_search,
    against: [:name, :song],
    associated_against: {
      artist: [:name]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
