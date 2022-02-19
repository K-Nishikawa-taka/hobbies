class FavoriteRoomsController < ApplicationController
  
  def create
    room = Room.find(params[:room_id])
    favorite_room = current_user.favorite_rooms.new(room_id: room.id)
    favorite_room.save
    redirect_to room_path(room.id)
  end
  
  def destroy
    room = Room.find(params[:room_id])
    favorite_room = current_user.favorite_rooms.find_by(room_id: room.id)
    favorite_room.destroy
    redirect_to room_path(room.id)
  end
  
end
