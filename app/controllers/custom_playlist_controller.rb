class CustomPlaylistController < ApplicationController

  before_action :already_exists?

  def create_playlist
    songs = []

    $spotify_user.top_artists(time_range: 'short_term', limit: 5).each do |artist|
       artist.related_artists.first(6).each do |i|
         if songs.exclude? i.top_tracks(:US).first.uri
           songs << i.top_tracks(:US).first.uri
         end
       end
    end

    songs.join(",")
    playlist = $spotify_user.create_playlist!('Discovery')
    playlist.add_tracks!(songs)

    CustomPlaylist.new(user_id: $spotify_user.display_name, playlist_id: playlist.id).save
    redirect_to root_path
  end

  private

  def already_exists?
    if CustomPlaylist.exists?(user_id: $spotify_user.display_name)
      flash[:success] = "We already made you one!"
    end
  end

end
