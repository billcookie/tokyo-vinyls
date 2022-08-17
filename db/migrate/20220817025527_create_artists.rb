class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.text :profile
      t.string :profile_img

      t.timestamps
    end
  end
end
