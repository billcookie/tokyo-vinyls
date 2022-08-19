class Artist < ApplicationRecord
  has_many :vinyls, dependent: :destroy
end
