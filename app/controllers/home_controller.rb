class HomeController < ApplicationController
  require 'rspotify'

  helper_method :get_features

  def index
  end

  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    @name = @spotify_user.display_name
    @playlists = @spotify_user.playlists
  end

  def playlist
    name = params[:name]
    id = params[:id]
    @playlist = RSpotify::Playlist.find(name, id)
  end

  private

  def get_features(playlist)
    total_energy = 0
    total_danceability = 0
    count = 0

    playlist.tracks.each do |i|
      total_energy += i.audio_features.energy
      total_danceability += i.audio_features.danceability
      count += 1
    end

    energy_average = (total_energy/count).round(2)
    energy_average = (energy_average * 100).to_i

    danceability_average = (total_danceability/count).round(2)
    danceability_average = (danceability_average * 100).to_i

    features = { energy: energy_average, danceability: danceability_average }
  end

  def home_params
    params.permit(:x)
  end
end
