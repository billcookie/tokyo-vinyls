class AddImageToVinyls < ActiveRecord::Migration[7.0]
  def change
    add_column :vinyls, :img_url, :string
  end
end
