class RoomsController < ApplicationController
  
  def index
    @rooms = Room.all.order(updated_at: :desc)
  end

  def create
    @genre = Genre.find(params[:room][:genre_id])
    @room = Room.new(room_params)
    @room.genre_id = @genre.id
    if @room.save
      redirect_to genre_path(@genre.id)
    else
      @rooms = Room.all.order(updated_at: :desc)
      render 'genres/show'
    end
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @messages = @room.messages.all.order(created_at: :desc)
  end

  def members
    @room = Room.find(params[:id])
    @favorite_rooms = FavoriteRoom.where(room_id: @room.id).all
  end

  # 管理者のみが使用可能
  def destroy
    if current_user.admin?
      room = Room.find(params[:id])
      room.destroy
      redirect_to rooms_path
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
