class CommentsController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = Message.find(params[:message_id])
    @comment = current_user.comments.new(comment_params)
    @comment.message_id = @message.id
    if @message.user_id == current_user.id
      @comment.is_read = true
    end
    if @comment.save
      flash[:notice] = "返信が送信されました"
      redirect_to room_message_path(@room.id, @message.id)
    else
      flash[:alert] = "コメントを入力してください"
      redirect_to room_message_path(@room.id, @message.id)
    end
  end

  def destroy
    @room = Room.find(params[:room_id])
    @message = Message.find(params[:message_id])
    @comment = Comment.find_by(id: params[:id])
    if ( @comment.user == current_user ) || ( current_user.admin == true )
      @comment.destroy
      flash[:notice] = "返信が削除されました"
      redirect_to room_message_path(@room.id, @message.id)
    else
      redirect_to room_message_path(@room.id, @message.id)
    end
  end

  def read
    comment = Comment.find(params[:id])
    comment.is_read = true
    comment.save
    flash[:notice] = "返信を既読しました"
    redirect_to room_message_path(comment.message.room.id, comment.message.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:words, :post_image)
  end
end
