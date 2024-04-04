Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  devise_for :users
  resources :books
  root to: "homes#top"

  
  resources :users, only: [:show,:index,:edit,:update]
  
  get 'home/about' => 'homes#about', as: 'about'
end
