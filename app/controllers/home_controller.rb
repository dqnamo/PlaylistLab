class HomeController < ApplicationController
  require 'rspotify'

  def index

    RSpotify.authenticate("58461ec83b874d08a8bcd731b61e09a3", "7017d0574a0c4bf4b31f5dd68f072c13")
    me = RSpotify::User.find('alanbiju79')
    @test = me.playlists

  end

end
