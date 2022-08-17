class CreateVinyls < ActiveRecord::Migration[7.0]
  def change
    create_table :vinyls do |t|
      t.string :name
      t.string :genre
      t.string :song
      t.integer :publishing_year

      t.timestamps
    end
  end
end
