class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @messages = @user.messages.page(params[:page]).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(@user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      if @user.update(user_params)
        redirect_to user_path(@user.id)
      else
        flash[:danger] = @user.errors.full_messages
        redirect_to edit_user_path(@user.id)
      end
    else
      redirect_to user_path(@user.id)
    end
  end

  def favorite_genres
    @user = User.find(params[:id])
    @favorite_genres = FavoriteGenre.where(user_id: @user.id).page(params[:page]).order(created_at: :desc)
  end

  def favorite_rooms
    @user = User.find(params[:id])
    @favorite_rooms = FavoriteRoom.where(user_id: @user.id).page(params[:page]).order(created_at: :desc)
  end

  def favorite_messages
    @user = User.find(params[:id])
    @favorite_messages = FavoriteMessage.where(user_id: @user.id).page(params[:page]).order(created_at: :desc)
  end

  def index
    if current_user.admin
      @users = User.page(params[:page])
    else
      redirect_to user_path(current_user)
    end
  end

  def confirm
  end

  def withdraw
    # 退会フラグを立てる
    current_user.update(is_deleted: true)
    # 退会者の個人コードを暗号化
    current_user.update(personal_code: Base64.encode64(current_user.personal_code))

    # ログイン状態を解除
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :personal_code, :introduction, :icon_image, :is_deleted)
  end

end
