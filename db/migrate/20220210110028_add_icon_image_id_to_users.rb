class AddIconImageIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :icon_image_id, :string
  end
end
