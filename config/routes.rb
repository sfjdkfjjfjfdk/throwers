Rails.application.routes.draw do

 root to: "user/homes#top"

  #会員側
  # URL /users/sign_in...
   devise_for :users,skip: [:passwords], controllers: {
   registrations: "user/registrations",
   sessions: 'user/sessions'
  }

  # マイページ
  scope module: 'user' do
     resources :users, only: [:show, :edit, :update, :destroy] do
      member do
       get :follows, :followers
      end
      resource :relationships, only: [:create, :destroy]
     end
   end

   get 'users/confirm' => 'user/users#confirm'

  # 投稿
   resources :posts do
     # いいね
     # URLにIDがいらないため、resourceにしている
     resource :likes, only: [:create, :destroy]
     # コメント
     resources :comments, only: [:create, :destroy]
   end

  # フォロー
   get '/users/user_id/relationship' => 'relationship#create'
   get '/users/user_id/relationship' => 'relationship#destroy'
   get '/users/user_id/follows' => 'users#follows', as: 'follows_users'
   get '/users/user_id/followers' => 'users#followers', as: 'followers_users'

  # 管理者側
  # URL /admin/sign_in...
   devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
  }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
