Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  jsonapi_resources :users
  # resources :groups, only: [:inex]
  get "groups/:id",  to: 'groups#show', format: :json
  get "groups",  to: 'groups#index'
end
