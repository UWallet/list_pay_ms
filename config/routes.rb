Rails.application.routes.draw do
  put '/lists', to: 'lists#update'
  delete '/lists', to: 'lists#destroy'
  resources :lists do
    collection do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get '/by_user', to: "lists#showPendingPaybyUser"
  end
  end
end
