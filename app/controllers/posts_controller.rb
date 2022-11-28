class PostsController < ApplicationController

  def new
     @post = Post.new
     @posts = current_user
  end

  def create
     @post = Post.new(post_params)
     @post.user_id = current_user.id
     if @post.save
       redirect_to post_path(@post)
     else
       render :new
     end
  end

  def index
     @posts = Post.page(params[:page]).per(5).order("created_at DESC")
     @post = current_user
     @my_posts = Post.where(user_id: current_user.id).includes(:user).order("created_at DESC")

  end

  def show
     @post = Post.find(params[:id])
     @comment = Comment.new
  end

  def edit
     @post = Post.find(params[:id])
     if @post.user == current_user
        render "edit"
     else
       redirect_to books_path
     end
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

  # 検索機能
  def search
     @posts = Post.search(params[:search])
     @post = Post.page(params[:page]).order("created_at DESC")
  end

  def myposts
     @my_posts = Post.where(user_id: current_user.id).page(params[:page]).includes(:user).order("created_at DESC")
     @my_post  = Post.page(params[:page]).order("created_at DESC")
  end

  private

  def post_params
     params.require(:post).permit(:name, :date, :weather, :time, :practice, :skill, :improvement, :profile_image)
  end


end