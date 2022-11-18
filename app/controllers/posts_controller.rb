class PostsController < ApplicationController

  def new
     @post = Post.new
     @posts = current_user
  end

  def create
     @post = Post.new(post_params)
     @post.user_id = current_user.id
     @post.save
      redirect_to posts_path
    # else

  end

  def index
     @posts = Post.all.order("created_at DESC")
    #  @posts = @posts.where('name, date LIKE ?', "%#{params[:search]}%") if params[:search].present?  #検索機能
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
     @post.update(post_params)
     redirect_to post_path
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