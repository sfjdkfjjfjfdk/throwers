class User::UsersController < ApplicationController
 # before_action :set_user, only: [:likes]

 def show
   @user = User.find(params[:id])
   @users = User.all
   @post = @user.posts
 end

 def edit
   @user = User.find(params[:id])
 end

 def update
   @user = current_user
   if @user.update(user_params)
     redirect_to  users_infomation_path
   else
     render :edit
   end
 end

 def likes
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
 end

 private

 def user_params
   params.require(:user).permit(:name, :event, :target, :task)
 end

end