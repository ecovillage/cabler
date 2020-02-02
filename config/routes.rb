Rails.application.routes.draw do
  root 'dashboard#show'
  resources :devices do
    resources :links, controller: 'devices/links'
    resource :label, controller: 'devices/label', only: :show
  end
  resources :locations
end
