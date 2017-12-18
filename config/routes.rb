Rails.application.routes.draw do

  get 'my_hotel/index'


  resources :locations
  post '/rate' => 'rater#create', :as => 'rate'
  resources :cities
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :hotels do
    resources :rooms do
      resources :orders
    end
    resources :locations
  end

  resources :rooms do
    resources :orders
  end

  resources :orders

  scope "/admin" do
    resources :users
  end

  resources :roles

  resource :geo_ip_request, controller: :geo_ip_request

  resources :hotel, :has_one => [:location]

  root "hotels#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
