class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :date_d
      t.date :date_f
      t.references :user, null: false, foreign_key: true
      t.references :chambre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
