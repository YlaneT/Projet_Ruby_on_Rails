class ChangeTypeCToBeStringInReservations < ActiveRecord::Migration[6.1]
  def change
    change_column :reservations, :type_c, :string
  end
end
