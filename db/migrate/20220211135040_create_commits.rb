class CreateCommits < ActiveRecord::Migration[5.2]
  def change
    create_table :commits do |t|
      t.integer :user_id
      t.integer :room_id
      t.text :words
      t.string :post_image_id

      t.timestamps
    end
  end
end
