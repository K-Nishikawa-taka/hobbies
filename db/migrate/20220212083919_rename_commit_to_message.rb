class RenameCommitToMessage < ActiveRecord::Migration[5.2]
  def change
    rename_table :commits, :messages
  end
end
