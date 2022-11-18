Rails.application.routes.draw do

 root to: "user/homes#top"

  #会員側
  # URL /users/sign_in...
   devise_for :users,skip: [:passwords], controllers: {
   registrations: "user/registrations",
   sessions: 'user/sessions'
  }

  # ユーザー
  scope module: 'user' do
     resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member do
       # フォロー、フォロワー
       get :follows, :followers 
       # いいね
       get :likes 
       # 退会確認画面
       get :confirm
      end
      # idが必要なためrelationshipsをネスト
      resource :relationships, only: [:create, :destroy]
     end
   end

    # 検索機能
    get "search" => "searches#search"
 
  # 投稿
   resources :posts do
     # いいね
     # URLにIDがいらないため、resourceにしている
     resource :likes, only: [:create, :destroy]
     # コメント
     resources :comments, only: [:create, :destroy]
   end

  # 管理者側
  # URL /admin/sign_in...
   devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
  }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
