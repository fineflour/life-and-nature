Rails.application.routes.draw do
  get 'pages/sitemap'
  get 'users/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
  devise_for :users#, :skip => [:registrations], :path_prefix => 'd'

  as :user do
    match '/users',   to: 'users#index',   via: 'get'
    #match '/users/:id',     to: 'users#show',       via: 'get'
    #get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    #put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  
  #resources :users, controllers: {sessions: "devise/sessions"#,:registrations => 'devise/registrations'}
  resources :users, only: [:index, :edit, :show, :new, :update, :create, :destroy]
  resources :questions_and_answers, only: [:index, :show, :new, :create, :edit, :update, :destroy] 
  resources :pt_resources, only: [:index, :edit, :show, :new, :update, :create, :destroy]

  get '/blogs/:id/:title' => 'pt_resources#show', :as => :pt_resource_with_title

  get "/sites/:site" => "sites#show"
  get "/pt_resources/dismiss_admin"
  get "/questions_and_answers/dismiss_admin"

  resources 'site' do
    resources :pt_resources, only: [:show]
  end 

  get 'sitemap', to: 'pages#sitemap', defaults: {format: 'xml'}
end
