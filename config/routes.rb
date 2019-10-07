Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#landing'

  get '/auth/spotify/callback', to: 'application#set_spotify_user'
  get '/log_out', to: 'application#log_out'

  get '/playlist/:id', to: 'home#playlist', as: :playlist
  get '/playlists', to: 'home#playlists'
  get '/create_playlist', to: 'custom_playlist#create_playlist'

  get '/add_energy/:id', to: 'enhance_playlist#add_energy', as: :add_energy
  get '/remove_energy/:id', to: 'enhance_playlist#remove_energy', as: :remove_energy

  get '/add_danceability/:id', to: 'enhance_playlist#add_danceability', as: :add_energy
  get '/remove_danceability/:id', to: 'enhance_playlist#remove_danceability', as: :remove_energy
end
