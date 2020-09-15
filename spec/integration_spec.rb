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

  describe('return to /albums, find previously created album, create second', 
    {:type => :feature}) do
    it('finds created album listed on /albums') do
      visit('/albums')
      expect(page).to(have_content('Flower Boy'))
    end
    it('creates a second album, taken to second album page on submit') do
      visit('/albums')
      click_on('Add new album')
      fill_in('album_name', :with  => 'Kind of Blue')
      fill_in('album_artist', :with  => 'Miles Davis')
      fill_in('album_year', :with  => '1959')
      fill_in('album_genre', :with  => 'Cool Jazz')
      click_on('Go!')
      expect(page).to(have_content('Kind of Blue'))
      expect(page).to(have_content('Miles Davis'))
      expect(page).to(have_content('1959'))
      expect(page).to(have_content('Cool Jazz'))
    end
  end

  describe('user may edit album information, submission returns user to album 
    page', {:type => :feature}) do
    it('edits album information, taken to edited album page on submit') do
      visit('/albums/2')
      click_on('Edit album')
      fill_in('name', :with  => 'Miles Ahead')
      fill_in('year', :with  => '1957')
      click_on('Update album')
      expect(page).to(have_content('Miles Ahead'))
      expect(page).to(have_content('Miles Davis'))
      expect(page).to(have_content('1957'))
      expect(page).to(have_content('Cool Jazz'))
    end
  end

  describe('user may delete an album, returns to main albums page', 
    {:type => :feature}) do
    it('deletes an album') do
      visit('/albums/2')
      click_on('Edit album')
      click_on('Delete album')
      expect(page).to(!have_content('Miles Ahead'))
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