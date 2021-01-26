class AddTypeCToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :type_c, :integer
  end
end
