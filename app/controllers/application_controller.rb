class ApplicationController < ActionController::Base

  def set_spotify_user
    $spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    redirect_to root_path
  end

  def log_out
    $spotify_user = nil
    redirect_to root_path
  end

end
