class MessagesController < ApplicationController
 
def create
    # 条件がtrueだったら、メッセージを保存するためにMessage.createとし、Messagesテーブルにuser_id、:content、room_idのパラメーターとして送られてきた値を許可
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      # メッセージを送ったのは現在ログインしているユーザーなので、そのuser_idの情報をmerge
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
　　redirect_to "/rooms/#{@message.room_id}"
  end
  
end
