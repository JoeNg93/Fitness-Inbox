Rails.application.routes.draw do

  scope '/api' do
    resources :clients, only: [:index, :create, :show]
    get '/clients/:id/messages', to: 'clients#messages', as: 'get_message'
    post '/clients/:id/markread', to: 'clients#mark_read'
    resources :messages, only: [:index, :create, :show]
  end

  post '/login', to: 'sessions#login'
  post '/logout', to: 'sessions#logout'

  get '/authenticate', to: 'sessions#authenticate'

  root 'application#index'
  get '*path', to: 'application#index'

end
