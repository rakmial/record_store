require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')

get('/') do
  "Welcome to record_store. We mostly have Death Grips."
end

get('/albums') do
  Album.all
end

get('/albums/new') do
  "Page with form to POST/create new album"
end

get('/albums/:id') do
  Album.find(#{params[:id]})
end

post('/albums') do
  "Adds an album to list of albums. Can't access by URL alone, have to use \
  form to specify POST action."
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

get('/custom_route') do
  "Custom routes are available but should only be used when needed."
end

get('/contact_us') do
  "Set a fire in a Barney's, and I will crawl out from a nearby sewer grate."