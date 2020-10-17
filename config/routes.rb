Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #shelters
  get '/', to: 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'

  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  #pets
  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  #shelter_pets
  get '/shelters/:id/pets', to: 'shelter_pets#index'
  get '/shelters/:id/pets/new', to: 'shelter_pets#new'
  post '/shelters/:id/pets', to: 'shelter_pets#create'

  #users
  get '/users/new', to: 'users#new'
  post '/users', to: 'users#create'
  get '/users/:id', to: 'users#show'

  #shelter_reviews
  get '/shelters/:shelter_id/reviews/new', to: 'shelter_reviews#new'
  post 'shelters/:shelter_id', to: 'shelter_reviews#create'
  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'shelter_reviews#edit'
  patch '/shelters/:shelter_id/reviews/:review_id', to: 'shelter_reviews#update'
  delete '/shelters/:shelter_id/reviews/:review_id', to: 'shelter_reviews#destroy'

  #applications
  get '/applications/:id', to: 'applications#show'
end
