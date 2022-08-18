class Vinyl < ApplicationRecord
  belongs_to :artist
  has_many :offers
  validates :name, presence: true
  validates :artist, presence: true

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
