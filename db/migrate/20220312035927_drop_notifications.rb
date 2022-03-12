class DropNotifications < ActiveRecord::Migration[5.2]
  def change
    drop_table :notifications do
      
    end
  end
end
