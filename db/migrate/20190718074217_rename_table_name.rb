class RenameTableName < ActiveRecord::Migration[5.2]
  def change
  	rename_table :uae_q2_bookings, :uae_q2_airline_bookings
  end
end
