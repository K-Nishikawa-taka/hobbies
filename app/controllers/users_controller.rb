class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def favorite_genres
    @user = User.find(params[:id])
    @favorite_genres = FavoriteGenre.where(user_id: @user.id).all
  end
  
  def favorite_rooms
    @user = User.find(params[:id])
    @favorite_rooms = FavoriteRoom.where(user_id: @user.id).all
  end
  
  def favorite_messages
    @user = User.find(params[:id])
    @favorite_messages = FavoriteMessage.where(user_id: @user.id).all
  end

  private

  def user_params
    params.require(:user).permit(:name, :personal_id, :introduction, :icon_image)
  end

end
