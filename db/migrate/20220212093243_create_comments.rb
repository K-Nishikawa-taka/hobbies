class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :message_id
      t.text :words
      t.string :post_image_id

      t.timestamps
    end
  end
end
