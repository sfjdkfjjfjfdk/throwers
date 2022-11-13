Rails.application.routes.draw do

#会員側
# URL /users/sign_in...
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
 }

# マイページ
  get '/users/infomation' => 'user/users#show'
  get '/users/infomation/:id/edit' => 'user/users#edit', as: 'edit_users'
  patch '/users/infomation' => 'user/users#update'

 # 投稿
  resources :posts do
     # いいね
     # URLにIDがいらないため、resourceにしている
     resource :likes, only: [:create, :destroy]
     # コメント
     resources :comments, only: [:create, :destroy]
  end

  # idが必要なため、memberを使用
  resources :users do
     member do
       get :likes
     end
end

# 管理者側
# URL /admin/sign_in...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
 }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
