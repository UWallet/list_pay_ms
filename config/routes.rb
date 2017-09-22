Rails.application.routes.draw do
  resources :lists do
    collection do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get '/by_user', to: "lists#showPendingPaybyUser"
  end
  end
end
