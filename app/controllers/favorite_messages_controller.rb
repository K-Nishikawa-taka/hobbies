class FavoriteMessagesController < ApplicationController
  def create
    @message = Message.find(params[:message_id])
    favorite_message = current_user.favorite_messages.new(message_id: @message.id)
    favorite_message.save
    @message.create_notification_favorite!(current_user)
  end

  def destroy
    @message = Message.find(params[:message_id])
    favorite_message = current_user.favorite_messages.find_by(message_id: @message.id)
    favorite_message.destroy
  end
end
