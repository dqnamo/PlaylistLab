class HomeController < ApplicationController
  require 'rspotify'

  def index
  end

  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    @playlists = @spotify_user.playlists
    render :playlists
  end

  private

  def get_energy
    @energy = Array.new
    total_energy = 0

    @playlists.each do |x|
      x.tracks.each do |i|
        total_energy += i.audio_features.energy
      end
      energy_average = total_energy/x.tracks.count
      @energy.push energy_average
      total_energy = 0;
    end
  end
end
