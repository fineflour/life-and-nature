Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
  devise_for :users, :skip => [:registrations]

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  
  resources :users
  resources :pt_resources, only: [:index, :edit, :show, :new, :update, :create, :destroy]
  resources :questions_and_answers, only: [:index, :show, :new, :create, :edit, :update, :destroy] 



  get "/sites/:site" => "sites#show"
  get "/pt_resources/dismiss_admin"
  get "/questions_and_answers/dismiss_admin"

  resources 'site' do
    resources :pt_resources, only: [:show]
  end 
end
