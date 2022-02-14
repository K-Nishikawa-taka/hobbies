class FavoriteMessagesController < ApplicationController
  
  def create
    message = Message.find(params[:message_id])
    favorite_message = current_user.favorite_messages.new(message_id: message.id)
    favorite_message.save
    redirect_to room_message_path(message.room.id, message.id)
  end
  
  def destroy
    message = Message.find(params[:message_id])
    favorite_message = current_user.favorite_messages.find_by(message_id: message.id)
    favorite_message.destroy
    redirect_to room_message_path(message.room.id, message.id)
  end
  
end
