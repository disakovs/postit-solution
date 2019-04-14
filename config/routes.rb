Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  
  
  get 'register', to: 'users#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  resources :categories, only: [:new, :create, :show]
  
  resources :posts, except: [:destroy] do
    member do
      post :vote
    end
    
    resources :comments, only: [:create] do
      member do
        post :vote
      end
    end
  end
  
  resources :users, only: [:create, :edit, :update, :show]
end
