class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.room_id = @room.id
    if @message.save
      redirect_to room_path(@room.id)
    else
      render 'rooms/show'
    end
  end

  def show
    @message = Message.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to user_path(current_user)
  end

  def favorite_users
    @message = Message.find(params[:id])
    @favorite_messages = FavoriteMessage.where(message_id: @message.id)
  end

  private

  def message_params
    params.require(:message).permit(:words, :post_image)
  end
end
