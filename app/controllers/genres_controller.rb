class GenresController < ApplicationController
  def index
    @genres = Genre.page(params[:page]).order(updated_at: :desc)
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path
    else
      @genres = Genre.page(params[:page]).order(updated_at: :desc)
      render :index
    end
  end

  def show
    @genre = Genre.find(params[:id])
    @rooms = @genre.rooms.page(params[:page]).order(updated_at: :desc)
    @room = Room.new
  end

  def members
    @genre = Genre.find(params[:id])
    @favorite_genres = FavoriteGenre.where(genre_id: @genre.id).page(params[:page])
  end

  # 管理者のみが使用可能
  def destroy
    if current_user.admin?
      genre = Genre.find(params[:id])
      genre.destroy
      redirect_to genres_path
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name, favorite_genres_attribute: [:user_id, :genre_id])
  end
end
