class ChangeNumToNb < ActiveRecord::Migration[6.1]
  def change
    rename_column :chambres, :num, :nb
  end
end
