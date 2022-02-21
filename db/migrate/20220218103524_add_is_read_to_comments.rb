class AddIsReadToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :is_read, :boolean, default: false
  end
end
