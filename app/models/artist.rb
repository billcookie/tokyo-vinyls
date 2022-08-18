class Artist < ApplicationRecord
  has_many :vinyls
  include PgSearch::Model
end
