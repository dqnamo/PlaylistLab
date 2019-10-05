Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#landing'

  get '/auth/spotify/callback', to: 'application#set_spotify_user'
  get '/log_out', to: 'application#log_out'

  get '/playlist/:id', to: 'home#playlist', as: :playlist
  get '/playlists', to: 'home#playlists'
  get '/create_playlist', to: 'custom_playlist#create_playlist'
end
