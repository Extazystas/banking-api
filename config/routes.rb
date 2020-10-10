Rails.application.routes.draw do
  devise_for :users, skip: :all
  namespace :api do
    post 'authenticate', to: 'authentication#authenticate'

    namespace :v1 do
      resources :currencies, only: [:index]
    end
  end
end
