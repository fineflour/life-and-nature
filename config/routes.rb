Rails.application.routes.draw do
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'


  resources :pt_resources, only: [:index, :edit, :show, :new, :update, :create, :destroy]
  resources :questions_and_answers, only: [:index, :show, :new, :create, :edit, :update, :destroy] 



  get "/sites/:site" => "sites#show"
end
