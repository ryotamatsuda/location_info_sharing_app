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
    resources :end_users, only: [:index]
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
