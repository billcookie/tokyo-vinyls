class AddDefaultStatusToBookings < ActiveRecord::Migration[7.0]
  def change
    change_column_default :bookings, :status, 0
  end
end
