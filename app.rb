require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "record_store"})

# Root route

get('/') do
  redirect to '/albums'
end

# Album routes

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
  name = params[:album_name]
  @album = Album.new({:name => name, :id => nil})
  @album.save()
  erb(:album)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  name = params[:name]
  @album.update(name)
  erb(:album)
end

delete('/albums/:id') do
  album = Album.find(params[:id].to_i)
  album.delete
  redirect to '/albums'
end

# Song routes

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

# Artist Routes

get('/artists') do
  @artists = Artist.all
  erb(:artists)
end

get('/artists/new') do
  erb(:new_artist)
end

get('/artists/:id') do
  @artist = Artist.find(params[:id].to_i)
  erb(:artist)
end

post('/artists') do
  name = params[:artist_name]
  @artist = Artist.new({:name => name, :id => nil})
  @artist.save()
  erb(:artist)
end

get('/artists/:id/edit') do
  @artist = Artist.find(params[:id].to_i())
  erb(:edit_artist)
end

patch('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  if name = params[:name]
    if album_name = params[:album_name]
      @artist.update({:name => name, :album_name => album_name})
    else
      @artist.update({:name => name})
    end
  elsif album_name = params[:album_name]
    @artist.update({:album_name => album_name})
  end
  erb(:artist)
end

delete('/artists/:id') do
  artist = Artist.find(params[:id].to_i)
  artist.delete
  redirect to '/artists'
end

# Custom Routes

get('/contact_us') do
  "Set a fire in a Barney's, and I will crawl out from a nearby sewer grate."
end