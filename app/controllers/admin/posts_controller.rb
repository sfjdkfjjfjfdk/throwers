class Admin::PostsController < ApplicationController

  def index
     @posts = Post.all
  end

  def show
     @post = Post.find(params[:id])
  end

  def edit
     @post = Post.find(params[:id])
  end

  def update
     @post = Post.find(params[:id])
     if @post.update(post_params)
       redirect_to admin_post_path
     else
       render :edit
     end
  end

  def destroy
     @post = Post.find(params[:id])
     @post.destroy
     flash[:notice] = '投稿を削除しました。'
     redirect_to admin_posts_path
  end

  # def myposts
  #   @my_posts = Post.where(user_id: current_user.id).page(params[:page]).includes(:user).order("created_at DESC")
  # end

  def post_params
    params.require(:post).permit(:name, :date, :weather, :time, :practice, :skill, :improvement, :profile_image)
  end

end
