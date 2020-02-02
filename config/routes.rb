Rails.application.routes.draw do
  root 'devices#index'
  resources :devices do
    resources :links, controller: 'devices/links'
  end
  resources :locations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
