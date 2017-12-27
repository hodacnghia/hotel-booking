Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'my_hotel/index' , :as => 'my_hotel'
  resources :locations
  resources :cities
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :hotels do
    resources :rooms do
      resources :orders, :except => [:index]
    end
    resources :locations

    collection do
        get :autocomplete
    end

    resources :picture , only: [:create, :destroy]
    

  end
  resources :orders, :only => [:index]

  resources :roles

  resource :geo_ip_request, controller: :geo_ip_request

  resources :hotel, :has_one => [:location]

  root "hotels#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
