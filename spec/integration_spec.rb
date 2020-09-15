require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('#app') do
  
  before(:all) do
    Album.clear
    Song.clear
  end

  describe('root and /albums display "no records" at first', {:type => :feature}) do
    it('visits / before creating an album, finds no records') do
      visit('/')
      expect(page).to(have_content("There are currently no records to display."))
    end
    it('visits /albums before creating an album, finds no records') do
      visit('/albums')
      expect(page).to(have_content("There are currently no records to display."))
    end
  end
end

  describe('create an album', {:type => :feature}) do
    it('creates an album and then goes to the album page') do
      visit('/albums')
      click_on('Add new album')
      fill_in('album_name', :with  => 'Flower Boy')
      fill_in('album_artist', :with  => 'Tyler, the Creator')
      fill_in('album_year', :with  => '2017')
      fill_in('album_genre', :with  => 'Hip Hop')
      click_on('Go!')
      expect(page).to(have_content('Flower Boy'))
      expect(page).to(have_content('Tyler, the Creator'))
      expect(page).to(have_content('2017'))
      expect(page).to(have_content('Hip Hop'))
    end
  end
# 
# describe('create a song path', {:type => :feature}) do
#   it('creates an album, creates a song, then goes to album page') do
#     album = Album.new("Revolver", "The Beatles", 1966, "Rock", nil)
#     album.save
#     visit("/albums/#{album.id}")
#     fill_in('song_name', :with => 'Yellow Submarine')
#     click_on('Add song')
#     expect(page).to(have_content('Yellow Submarine'))
#   end
# end

#  Integrations Specification
#
#* paths '/' and '/albums' both route user to albums.erb, which should start out 
#  displaying no albums, ie displaying the text "There are currently no records 
#  to display."
#
#* User may create new album, which creates an album path. Album is filled in with 
#  name, artist, year, and genre. When submitted, user is taken to album page.
#
#* When user returns to '/' or '/albums' homepage, the previously-created album will
#  be displayed. User may create a second album, which will take user to second album
#  page on submission.
#
#* User may edit albums to update album information. Submission of edited information
#  will return user to album page to display updated information. 
#  
#* User may find a button to delete an album from the albums store in the edit link. 
#  Deleting an album removes it from the store and takes user to main albums page.
#
#* User may use the search bar in '/' or '/albums' to filter available albums by 
#  criteria selected from the dropdown menu.
#
#* User may use the sort button in '/' or '/albums' to sort the albums list by 
#  criteria selected from dropdown menu.
#
#* On an album's page, user may add new songs to that album. Songs created will be
#  displayed on a list in the album's page.
#
#* Songs have their own pages, displaying song and album names. User may update 
#  the song's name or delete the song. Updating a song returns user to the song
#  page, and deleting returns user to album page.
#
#* Special route '/contact_us' is provided.