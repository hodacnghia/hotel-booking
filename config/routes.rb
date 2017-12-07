Rails.application.routes.draw do
  
  post '/rate' => 'rater#create', :as => 'rate'
  resources :cities
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :hotels do
    resources :rooms
  end

  scope "/admin" do
    resources :users
  end
  
  resources :roles
  root "hotels#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
