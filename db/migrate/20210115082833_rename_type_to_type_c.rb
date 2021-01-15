class RenameTypeToTypeC < ActiveRecord::Migration[6.1]
  def change
    rename_column :chambres, :type, :type_c
  end
end
