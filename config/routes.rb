Rails.application.routes.draw do
  root 'dashboard#show'
  resources :devices do
    resources :links, controller: 'devices/links'
  end
  resources :locations
end
