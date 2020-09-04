require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
  @albums = Album.all
  erb(:albums)
end

get('/albums') do
  binding.pry
  @albums = Album.all
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

get('/albums/:id') do
  Album.find("#{params[:id]}")
end

post('/albums') do
  name = params[:album_name]
  album = Album.new(name, nil)
  album.save()
  @albums = Album.all()
  erb(:albums)
end

get('/albums/:id/edit') do
  "Page with form for PATCH/update with ID #{params[:id]}."
end

patch('/albums/:id') do
  "Updates album with ID #{params[:id]}, must come from form action rather than |
  URL alone."
end

delete('/albums/:id') do
  "Deletes album at ID. Like PATCH and POST, can't be reached through URL alone, \
  comes via form or button."
end

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