class RenamePersonalIdToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :personal_id, :personal_code
  end
end
