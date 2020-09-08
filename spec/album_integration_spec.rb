require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create an album path', {:type => :feature}) do
  it('creates an album and then goes to the album page') do
    visit('/albums')
    click_on('Add new album')
    fill_in('album_name', :with  => 'Yellow Submarine')
    click_on('Go!')
    expect(page).to(have_content('Yellow Submarine'))
  end
end

describe('create a song path', {:type => :feature}) do
  it('creates an album, creates a song, then goes to album page') do
    album = Album.new("Revolver", "The Beatles", 1966, "Rock", nil)
    album.save
    visit("/albums/#{album.id}")
    fill_in('song_name', :with => 'Yellow Submarine')
    click_on('Add song')
    expect(page).to(have_content('Yellow Submarine'))
  end
end