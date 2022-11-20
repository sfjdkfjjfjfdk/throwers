class PostsController < ApplicationController

  def new
     @post = Post.new
     @posts = current_user
  end

  def create
     @post = Post.new(post_params)
     @post.user_id = current_user.id
     if @post.save
       redirect_to posts_path
     else
       render :new
     end
  end

  def index
     @posts = Post.all.order("created_at DESC")
     @post = current_user
  end

  def show
     @post = Post.find(params[:id])
     @comment = Comment.new
     @user = @post.user
  end

  def edit
     @post = Post.find(params[:id])
  end

  def update
     @post = Post.find(params[:id])
     if @post.update(post_params)
       redirect_to post_path
     else
       render :edit
     end
  end

  def destroy
     @post = Post.find(params[:id])
     @post.destroy
     redirect_to posts_path
  end

  private

  def post_params
     params.require(:post).permit(:name, :date, :weather, :time, :practice, :skill, :improvement)
  end


end