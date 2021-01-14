class CreateChambres < ActiveRecord::Migration[6.1]
  def change
    create_table :chambres do |t|
      t.integer :num
      t.string :type
      t.integer :prix

      t.timestamps
    end
  end
end
