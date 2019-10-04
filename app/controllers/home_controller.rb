class HomeController < ApplicationController
  require 'rspotify'

  before_action :authenticate_user, except: [:landing]

  helper_method :get_features, :make_playlist

  def landing
    if $spotify_user != nil
      redirect_to playlists_path
    end
  end

  def playlists
    @playlists = $spotify_user.playlists
  end

  def playlist
    id = params[:id]
    name = $spotify_user.display_name
    @playlist = RSpotify::Playlist.find(name, id)
  end

  private

  def get_features(playlist)
    total_energy = 0
    total_danceability = 0
    count = 0

    playlist.tracks.each do |i|
      features = i.audio_features
      total_energy += features.energy
      total_danceability += features.danceability
      count += 1
    end

    energy_average = (total_energy/count).round(2)
    energy_average = (energy_average * 100).to_i

    danceability_average = (total_danceability/count).round(2)
    danceability_average = (danceability_average * 100).to_i

    features = { energy: energy_average, danceability: danceability_average }
  end

  def make_playlist
    songs = []

    @spotify_user.top_artists(time_range: 'short_term', limit: 5).each do |artist|
       artist.related_artists.each do |i|
         songs << i.top_tracks(:US).first.name
       end
    end
    puts songs
  end

  def home_params
    params.permit(:id)
  end

  def authenticate_user
    if $spotify_user == nil
      redirect_to root_path
    end
  end

end
