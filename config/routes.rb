Rails.application.routes.draw do

  get 'rooms/show'
 root to: "user/homes#top"

  #会員側
  # URL /users/sign_in...
   devise_for :users,skip: [:passwords], controllers: {
   registrations: "user/registrations",
   sessions: "user/sessions"
  }

  # ユーザー
  scope module: "user" do
     resources :users, only: [:show, :edit, :update, :destroy] do
      # idを含ませるため、member
      member do
       # フォロー、フォロワー
       get :follows, :followers
       # いいね
       get :likes
       # 退会確認画面
       get :confirm
       # ユーザー検索
       get :search
      end
      # relationshipsをネスト
      resource :relationships, only: [:create, :destroy]
     end
    end

  # 投稿
   resources :posts do
    # idを含ませないため、collection
    collection do
     # 投稿検索
     get :search
     # 自分の投稿一覧
     get :myposts
    end
     # いいね
     # URLにIDがいらないため、resourceにしている
     resource :likes, only: [:create, :destroy]
     # コメント
     resources :comments, only: [:create, :destroy]
   end

  # 管理者側
  # URL /admin/sign_in...
   devise_for :admin, skip: [:passwords] ,controllers: {
   sessions: "admin/sessions"
  }

  namespace :admin do
   resources :users, only: [:index, :show, :edit, :update, :destroy]
   resources :posts do
    # get :myposts
   end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end