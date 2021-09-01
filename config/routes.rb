Rails.application.routes.draw do
  resources :payers
  post '/transaction', :to => 'transactions#create'
end
