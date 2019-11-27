class EnhancePlaylistController < ApplicationController

  before_action :get_artists, :get_playlist_tracks

  def add_energy
    songs = []

    @artists.each do |i|
      i = RSpotify::Artist.find(i)
      i.top_tracks(:US).first(10).each do |j|
        energy = j.audio_features.energy * 100

        if (energy > $features[:energy]) && (songs.exclude? j.uri) && (@playlist_tracks.exclude? j.uri)
          songs << j.uri
        end

        if songs.count > 9
          break
        end
      end
    end

    if songs.empty?
      get_related_artists
      add_energy
    end

    add_to_playlist(songs)

    flash[:notice] = "Added #{songs.count} songs to increase energy."
    redirect_to playlist_path(params[:id])
  end

  def remove_energy
    songs = []
    @artists.each do |i|
      i.top_tracks(:US).first(10).each do |j|
        energy = j.audio_features.energy * 100

        if (energy < $features[:energy]) && (songs.exclude? j.uri) && (@playlist_tracks.exclude? j.uri)
          songs << j.uri
        end

        if songs.count > 9
          break
        end
      end
    end

    if songs.empty?
      get_related_artists
      add_energy
    end

    add_to_playlist(songs)

    flash[:notice] = "Added #{songs.count} songs to decrease energy."
    redirect_to playlist_path(params[:id])
  end

  def add_danceability
    songs = []
    @artists.each do |i|
      i.top_tracks(:US).first(10).each do |j|
        danceability = j.audio_features.danceability * 100

        if (danceability > $features[:danceability]) && (songs.exclude? j.uri) && (@playlist_tracks.exclude? j.uri)
          songs << j.uri
        end

        if songs.count > 9
          break
        end
      end
    end

    if songs.empty?
      get_related_artists
      add_danceability
    end

    add_to_playlist(songs)

    flash[:notice] = "Added #{songs.count} songs to increase danceability."
    redirect_to playlist_path(params[:id])
  end

  def remove_danceability
    songs = []
    @artists.each do |i|
      i.top_tracks(:US).first(10).each do |j|
        danceability = j.audio_features.danceability * 100

        if (danceability < $features[:danceability]) && (songs.exclude? j.uri) && (@playlist_tracks.exclude? j.uri)
          songs << j.uri
        end

        if songs.count > 9
          break
        end
      end
    end

    if songs.empty?
      get_related_artists
      add_danceability
    end

    add_to_playlist(songs)

    "Added #{songs.count} songs to decrease danceability."
    redirect_to playlist_path(params[:id])
  end

  private

  def add_to_playlist(songs)
    songs.join(",")
    puts songs
    @playlist.add_tracks!(songs)
  end

  def get_artists
    id = params[:id]
    name = $spotify_user.display_name
    @playlist = RSpotify::Playlist.find(name, id)
    tracks = @playlist.tracks

    @artists = []

    tracks.each do |x|
      if @artists.exclude? x.artists.first.id
        @artists << x.artists.first.id
      end
    end

    #debugger

    return @artists.first(20)
  end

  def get_related_artists
    related = []

  #TODO
    @artists.each do |k|
      k.related_artists.first(5).each do |y|
        if related.exclude? y.id
          related << y.id
        end
      end
    end

    @artists = related
  end

  def get_playlist_tracks
    @playlist_tracks = []

    @playlist.tracks.each do |track|
      @playlist_tracks << track.uri
    end
  end

  def enhance_playlist_params
    params.permit(:id)
  end

end
