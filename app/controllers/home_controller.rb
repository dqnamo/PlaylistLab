class HomeController < ApplicationController
  require 'rspotify'

  def index
  end

  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    @playlists = @spotify_user.playlists
  end

end
