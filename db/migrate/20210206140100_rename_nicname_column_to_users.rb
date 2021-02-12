class RenameNicnameColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :nicname, :nickname
  end
end
