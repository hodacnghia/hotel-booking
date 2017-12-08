Rails.application.routes.draw do

  get 'my_hotel/index'

  devise_for :users
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
