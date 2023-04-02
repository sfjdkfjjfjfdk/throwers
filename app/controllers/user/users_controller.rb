class User::UsersController < ApplicationController

 def show
   @user = User.find(params[:id])
   @users = User.all
   @following_users = @user.following_user
   @follower_users = @user.follower_user
 end

 def edit
   @user = User.find(params[:id])
   if @user == current_user
     render "edit"
   else
     redirect_to user_path
   end
 end

 def update
   @user = User.find(params[:id])
   if @user.update(user_params)
     redirect_to  user_path
   else
     render :edit
   end
 end

 def destroy
   @user = User.find(params[:id])
   @user.destroy
   flash[:notice] = '退会処理が完了しました。'
   redirect_to :root #削除に成功すればrootページに戻る
 end

 def likes
   @user = User.find(params[:id])
   likes = Like.where(user_id: @user.id).pluck(:post_id)
   @like_posts = Post.find(likes)
   @user = User.find(params[:id])
 end

 # フォロー一覧
 def follows
   user = User.find(params[:id])
   @users = user.following_user
   @user = User.find(params[:id])
 end

 # フォロワー一覧
 def followers
   user = User.find(params[:id])
   @users = user.follower_user
   @user = User.find(params[:id])
 end

 # 検索機能
 def search
   @users = User.search(params[:search])
 end

 private

 def user_params
   params.require(:user).permit(:name, :event, :target, :task, :profile_image)
 end

end