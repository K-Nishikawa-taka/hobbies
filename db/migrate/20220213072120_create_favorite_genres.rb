class CreateFavoriteGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_genres do |t|
      t.string :user_id
      t.string :genre_id

      t.timestamps
    end
  end
end
