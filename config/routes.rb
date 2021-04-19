Rails.application.routes.draw do
  devise_scope :end_user do
    root "end_users/sessions#new"
  end
  devise_for :end_users, :controllers => {
    :sessions => 'end_users/sessions',
    :passwords => 'end_users/passwords',
    :registrations => 'end_users/registrations',
    :confirmations => 'end_users/confirmations'
  }
  scope module: :end_users do
    resources :end_users, only: [:index, :show]
    get '/end_users/:id/follow_index' => 'end_users#follow_index', as: 'follow_index'
    get '/end_users/:id/follower_index' => 'end_users#follower_index', as: 'follower_index'
    resources :appeals, only: [:index, :new, :create]
    post '/relationships/:followed_end_user_id' => 'relationships#create', as: 'follow'
    delete '/relationships/:unfollowed_end_user_id' => 'relationships#destroy', as: 'unfollow'
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
