Rails.application.routes.draw do

  scope '/api' do
    resources :clients, only: [:index, :create, :show]
    get '/clients/:id/messages', to: 'clients#messages', as: 'get_message'
    resources :messages, only: [:index, :create, :show]
  end

end
