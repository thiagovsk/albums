module AlbumsHelper
  def artists_select
    artists = ::Albums::ListArtists.call
    artists.map { |_key, value| [value['name']] }
  end
end
