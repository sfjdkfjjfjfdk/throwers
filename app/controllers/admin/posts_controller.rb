class Admin::PostsController < ApplicationController

  def index
     @posts = Post.all
  end

  def show
     @post = Post.find(params[:id])
  end

  def myposts
     @my_posts = Post.where(user_id: current_user.id).page(params[:page]).includes(:user).order("created_at DESC")
  end

end
