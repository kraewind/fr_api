Rails.application.routes.draw do
  get '/balance', :to => 'payers#index'
  post '/transaction', :to => 'transactions#create'
  patch '/spend', :to => 'transactions#update'
end
