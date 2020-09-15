require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
  @albums = Album.all
  erb(:albums)
end

get('/albums') do
  @albums = Album.all
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i)
  erb(:album)
end

post('/albums') do
  if params[:album_name]
    name = params[:album_name]
    artist = params[:album_artist]
    year = params[:album_year].to_i
    genre = params[:album_genre]
    @album = Album.new(name, artist, year, genre, nil)
    @album.save()
    erb(:album)
  elsif params[:search]
    @albums = Album.search(params[:search], params[:search_by])
    erb(:albums)
  elsif params[:sort_by]
    @albums = Album.sort(params[:sort_by])
    erb(:albums)
  end
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  name = params[:name]
  artist = params[:artist]
  year = params[:year]
  genre = params[:genre]
  @album.update(name, artist, year, genre)
  erb(:album)
end

delete('/albums/:id') do
  album = Album.find(params[:id].to_i)
  album.delete
  @albums = Album.all
  erb(:albums)
end

get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i)
  erb(:song)
end

post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i)
  song = Song.new(params[:song_name], @album.id, nil)
  song.save
  erb(:album)
end

patch('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i)
  @song.update(params[:name], @song.album_id)
  erb(:song)
end

delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i)
  song.delete
  @album = Album.find(params[:id].to_i)
  erb(:album)
end

# Custom Routes

get('/test') do
  @something = "this is a variable"
  erb(:whatever)
end

get('/custom_route') do
  "Custom routes are available but should only be used when needed."
end

get('/contact_us') do
  "Set a fire in a Barney's, and I will crawl out from a nearby sewer grate."
end