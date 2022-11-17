class User::UsersController < ApplicationController
 # before_action :set_user, only: [:likes]

 def show
   @user = User.find(params[:id])
   @users = User.all
   @post = @user.posts
   # @following_users = @user.following_user
   # @follower_users = @user.follower_user
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


 private

 def user_params
   params.require(:user).permit(:name, :event, :target, :task)
 end

end