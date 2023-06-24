Rails.application.routes.draw do
  get 'contacts/index'
  get 'subscriptions/index'
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
  resources :subscriptions, only: [:index, :show, :new, :create, :edit, :update, :destroy] 
  resources :contacts, only: [:index, :show, :new, :create, :edit, :update, :destroy] 
  resources :pt_resources, only: [:index, :edit, :show, :new, :update, :create, :destroy]
  resources :products, only: [:index, :edit, :show, :new, :update, :create, :destroy]
  resources :categories, only: [:index, :edit, :show, :new, :update, :create, :destroy]
  resources :product_categories, only: [:index, :edit, :show, :new, :update, :create, :destroy]
  resources :diagno_questions, only: [:index, :edit, :show, :new, :update, :create, :destroy]
  resources :dgns_answers, only: [:index, :edit, :show, :new, :update, :create, :destroy]
  resources :diagno_user_answers, only: [:index, :edit, :show, :new, :update, :create, :destroy]

  get '/blogs/:id/:title' => 'pt_resources#blog', :as => :pt_resource_with_title

  get "/sites/:site" => "sites#show"
  get "/pt_resources/dismiss_admin"
  get "/questions_and_answers/dismiss_admin"
  #get "/diagno_questions/save_answers/:id"
  match '/diagno_questions/:id/save_answers', to: 'diagno_questions#save_answers',       via: 'get'

#  match '/users/:id',     to: 'users#show',       via: 'get'

  resources :landings, only: [:index, :edit, :show, :new, :update, :create, :destroy]

  resources 'site' do
    resources :pt_resources, only: [:show]
  end 

  get 'sitemap', to: 'pages#sitemap', defaults: {format: 'xml'}
end
