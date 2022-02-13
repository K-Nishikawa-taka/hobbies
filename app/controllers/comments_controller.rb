class CommentsController < ApplicationController

  def create
    @room = Room.find(params[:room_id])
    @message = Message.find(params[:message_id])
    @comment = current_user.comments.new(comment_params)
    @comment.message_id = @message.id
    if @comment.save
      redirect_to room_message_path(@room.id, @message.id)
    else
      render 'message/show'
    end
  end

  def destroy
    @room = Room.find(params[:room_id])
    @message = Message.find(params[:message_id])
    Comment.find_by(id: params[:id]).destroy
    redirect_to room_message_path(@room.id, @message.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:words, :post_image)
  end

end