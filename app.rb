require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')
require('./lib/song')

# ruby app.rb for Sinatra
# localhost:4567

get('/') do
  @albums = Album.all
  @sold_out = Album.get_sold
  erb(:albums)
end

get('/albums') do
  @sold_out = Album.get_sold
  if params[:search]
    @albums = Album.search(params[:search])
  elsif params[:sort]
    @albums = Album.sort(params[:sort])
  else
    @albums = Album.all
  end
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

post('/albums') do
  name = params[:album_name]
  artist = params[:album_artist]
  genre = params[:album_genre]
  album = Album.new(name, nil, artist, genre)
  album.save()
  @albums = Album.all()
  @sold_out = Album.get_sold
  # binding.pry
  erb(:albums)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/albums/:id/edit') do
@album = Album.find(params[:id].to_i())
erb(:edit_album)
end

patch('/albums/:id') do
@album  = Album.find(params[:id].to_i())
@album.update(params[:name])
@albums = Album.all
@sold_out = Album.get_sold
erb(:albums)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  @sold_out = Album.get_sold
  erb(:albums)
end

# Get the detail for a specific song such as lyrics and songwriters.
get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

# Post a new song. After the song is added, Sinatra will route to the view for the album the song belongs to.
post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new(params[:song_name], @album.id, nil)
  song.save()
  erb(:album)
end

# Edit a song and then route back to the album view.
patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

# Delete a song and then route back to the album view.
delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end


# get('/custom_route') do
#   "We can even create custom routes, but we should only do this when needed."
# end
