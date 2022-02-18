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
  
  def index
    if current_user.admin
      @users = User.all
    end
  end
  
  def confirm
  end
  
  def withdraw
    #退会フラグを立てる
    current_user.update(is_deleted: true)
    #退会者の個人コードを暗号化
    current_user.update(personal_id: Base64.encode64(current_user.personal_id))

    #ログイン状態を解除
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :personal_id, :introduction, :icon_image)
  end

end
