class AddArtistRefToVinyl < ActiveRecord::Migration[7.0]
  def change
    add_reference :vinyls, :artist, null: false, foreign_key: true
  end
end
