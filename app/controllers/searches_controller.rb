class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    # 検索モデル
    @range = params[:range]

    if @range == "User"
      # 検索方法はparams[:search]、検索ワードはparams[:word]
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end

end
