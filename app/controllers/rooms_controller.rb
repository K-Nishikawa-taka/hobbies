class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to genre_path(@genre.id)
    else
      render 'genres/show'
    end
  end

  def show
    @room = Room.find(params[:id])
  end
  
  private
  
  def room_params
    params.require(:room).permit(:name)
  end
  
end
