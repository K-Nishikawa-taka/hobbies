class ChangeDateUserIdToFavoriteGenre < ActiveRecord::Migration[5.2]
  def change
    change_column :favorite_genres, :user_id, :integer
  end
end
