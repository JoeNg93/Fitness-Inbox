Rails.application.routes.draw do

  scope '/api' do
    resources :clients, only: [:index, :create, :show]
    resources :messages, only: [:index, :create, :show]
  end

end
