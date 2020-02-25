Rails.application.routes.draw do
  devise_for :users
  root 'dashboard#show'
  resources :devices do
    resources :links, controller: 'devices/links'
    resource :label, controller: 'devices/label', only: :show
  end
  resources :locations

  get 'topology', to: 'topology#show'
  resource :topology, only: [:show], as: :graph_configurations

  get 'changelog', to: 'pages#changelog'
end
