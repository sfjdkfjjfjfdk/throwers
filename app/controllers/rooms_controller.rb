class RoomsController < ApplicationController
  
  before_action :authenticate_user!

  def create
    @room = Room.create
    # 現在ログインしているユーザー
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    # フォローされている側の情報をEntriesテーブルに保存する
    # 保存したparamsの情報(:user_id, :room_id)を許可し、現在ログインしているユーザーと同じく@roomにひもづくidを保存する
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    # redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    # 条件としてはまず、Entriesテーブルに、現在ログインしているユーザーのidとそれにひもづいたチャットルームのidをwhereメソッドで探し、そのレコードがあるか確認
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
      # Messageテーブルにそのチャットルームのidと紐づいたメッセージを表示させる
      # @messagesにアソシエーションを利用した@room.messagesという記述を代入
      @messages = @room.messages
      @message = Message.new
      # ユーザーの名前などの情報を表示させるために、@room.entriesを@entriesというインスタンス変数に入れ、Entriesテーブルのuser_idの情報を取得
      @entries = @room.entries
    else
      # 条件がfalseだったら、前のページに戻る
      # redirect_back(fallback_location: root_path)
    end
  end

end