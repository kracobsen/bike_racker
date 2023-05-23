Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "bike_racks#index"
  resources :bike_racks, only: [:index] do
    get :search, on: :collection
    get :bikes_available, on: :collection
    get :locks_available, on: :collection
  end
end
