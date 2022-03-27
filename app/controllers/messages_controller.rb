class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.room_id = @room.id
    if @message.save
      flash[:notice] = "投稿できました"
      redirect_to room_path(@room.id)
    else
      flash[:alert] = "コメントを入力してください"
      redirect_to room_path(@room.id)
    end
  end

  def show
    @message = Message.find(params[:id])
    @comment = Comment.new
    @comments = @message.comments.page(params[:page])
  end

  def destroy
    @message = Message.find(params[:id])
    if ( @message.user == current_user ) || ( current_user.admin == true )
      @message.destroy
      flash[:notice] = "メッセージが削除されました"
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def time_line
    @messages = Message.where(user_id: [current_user.id, *current_user.following_ids]).page(params[:page]).order(created_at: :desc)
  end

  def favorite_users
    @message = Message.find(params[:id])
    @favorite_messages = FavoriteMessage.where(message_id: @message.id).page(params[:page])
  end

  private

  def message_params
    params.require(:message).permit(:words, :post_image)
  end
end
