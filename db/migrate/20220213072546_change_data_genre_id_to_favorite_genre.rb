class ChangeDataGenreIdToFavoriteGenre < ActiveRecord::Migration[5.2]
  def change
    change_column :favorite_genres, :genre_id, :integer
  end
end
