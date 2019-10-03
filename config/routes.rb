Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/auth/spotify/callback', to: 'home#spotify'

  get '/playlist/:name/:id', to: 'home#playlist', as: :playlist
end
