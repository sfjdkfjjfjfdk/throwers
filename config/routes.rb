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

# 管理者側
# URL /admin/sign_in...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

#マイページ

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
