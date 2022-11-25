class User::UsersController < ApplicationController
 before_action :authenticate_user!,except: [:top]

 def show
   @user = User.find(params[:id])
   @users = User.all
   @following_users = @user.following_user
   @follower_users = @user.follower_user
 end

 def edit
   @user = User.find(params[:id])
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
   if @user.destroy
     flash[:notice] = 'ユーザーを削除しました。'
     redirect_to :root #削除に成功すればrootページに戻る
   else
     render :show
   end
 end

 def likes
   @user = User.find(params[:id])
   likes = Like.where(user_id: @user.id).pluck(:post_id)
   @like_posts = Post.find(likes)
 end

 # フォロー一覧
 def follows
   user = User.find(params[:id])
   @users = user.following_user
 end

 # フォロワー一覧
 def followers
   user = User.find(params[:id])
   @users = user.follower_user
 end

 # 検索機能
 def search
   @users = User.search(params[:search])
 end

 private

 def user_params
   params.require(:user).permit(:name, :event, :target, :task)
 end

end