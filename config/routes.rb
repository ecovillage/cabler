Rails.application.routes.draw do
  devise_for :users

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

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
