class FavoriteGenresController < ApplicationController
  
  def create
    genre = Genre.find(params[:genre_id])
    favorite_genre = current_user.favorite_genres.new(genre_id: genre.id)
    favorite_genre.save
    redirect_to genre_path(genre.id)
  end
  
  def destroy
    genre = Genre.find(params[:genre_id])
    favorite_genre = current_user.favorite_genres.find_by(genre_id: genre.id)
    favorite_genre.destroy
    redirect_to genre_path(genre.id)
  end
  
end
