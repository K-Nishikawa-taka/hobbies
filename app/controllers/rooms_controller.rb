class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def create
    @genre = Genre.find(params[:room][:genre_id])
    @room = Room.new(room_params)
    @room.genre_id = @genre.id
    if @room.save
      redirect_to genre_path(@genre.id)
    else
      render 'genres/show'
    end
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new
   end

  private

  def room_params
    params.require(:room).permit(:name)
  end

end
