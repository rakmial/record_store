require('capybara/rspec')
require('pry')
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
      expect(page).not_to(have_content('Miles Ahead'))
    end
  end

  describe('user may use search bar in / or /albums to filter available albums 
    by criteria in dropdown menu', {:type => :feature}) do
    it('filters by album name') do
      visit('/albums')
      click_on('Add new album') # Add 2nd album to compare search results
      fill_in('album_name', :with  => 'Kind of Blue')
      fill_in('album_artist', :with  => 'Miles Davis')
      fill_in('album_year', :with  => '1959')
      fill_in('album_genre', :with  => 'Cool Jazz')
      click_on('Go!')
      click_on('Return to album list')
      select('Album Name', from: "search_by")
      fill_in('search', :with => 'Kind of Blue')
      click_on('Go!')
      expect(page).to(have_content('Kind of Blue'))
      expect(page).not_to(have_content('Flower Boy'))
    end
    it('filters by album artist') do
      visit('/albums')
      select('Artist Name', from: "search_by")
      fill_in('search', :with => 'Tyler, the Creator')
      click_on('Go!')
      expect(page).not_to(have_content('Kind of Blue'))
      expect(page).to(have_content('Flower Boy'))
    end
    it('filters by album year') do
      visit('/albums')
      select('Release Year', from: 'search_by')
      fill_in('search', :with => '19')
      click_on('Go!')
      expect(page).to(have_content('Kind of Blue'))
      expect(page).not_to(have_content('Flower Boy'))
    end
    it('filters by genre') do
      visit('/albums')
      select('Genre', from: 'search_by')
      fill_in('search', :with => 'Hip Hop')
      click_on('Go!')
      expect(page).not_to(have_content('Kind of Blue'))
      expect(page).to(have_content('Flower Boy'))
    end
  end

  describe('user may use sorting dropdown to sort by different album fields', 
    {:type => :feature}) do
    it('can sort by album name') do
      visit('/albums')
      select('Album Name', from: 'sort_by')
      click_on('Sort!')
      within "li.record:nth-child(1)" do
        expect(page).to(have_content('Flower Boy'))
      end
      within "li.record:nth-child(2)" do
        expect(page).to(have_content('Kind of Blue'))
      end
    end
    it('can sort by artist name') do
      visit('/albums')
      select('Artist Name', from: 'sort_by')
      click_on('Sort!')
      within "li.record:nth-child(1)" do
        expect(page).to(have_content('Kind of Blue'))
      end
      within "li.record:nth-child(2)" do
        expect(page).to(have_content('Flower Boy'))
      end
    end
    it('can sort by album year') do
      visit('/albums')
      select('Release Year', from: 'sort_by')
      click_on('Sort!')
      within "li.record:nth-child(1)" do
        expect(page).to(have_content('Kind of Blue'))
      end
      within "li.record:nth-child(2)" do
        expect(page).to(have_content('Flower Boy'))
      end
    end
    it('can sort by genre') do
      visit('/albums')
      select('Genre', from: 'sort_by')
      click_on('Sort!')
      within "li.record:nth-child(1)" do
        expect(page).to(have_content('Kind of Blue'))
      end
      within "li.record:nth-child(2)" do
        expect(page).to(have_content('Flower Boy'))
      end
    end
  end

  describe('user may add songs to albums, and album pages will list songs', 
  {:type => :feature}) do
    it('allows user to make a song on an album') do
      visit('/albums')
      click_on('Flower Boy')
      fill_in('song_name', :with => "Garden Shed")
      click_on('Add song')
      expect(page).to(have_content("Garden Shed"))
    end
    it('allows user to visit individual song pages by clicking on song link') do
      visit('/albums/1')
      click_on('Garden Shed')
      expect(page).to(have_content("Flower Boy"))
      expect(page).to(have_content("Garden Shed"))
    end
    it('gives the user ability to update song name') do
      visit('/albums/1/songs/1')
      fill_in('name', :with => 'Boredom')
      click_on('Update Song')
      expect(page).to(have_content('Boredom'))
    end
  end
end

#  Integrations Specification
#
#* Songs have their own pages, displaying song and album names. User may update 
#  the song's name or delete the song. Updating a song returns user to the song
#  page, and deleting returns user to album page.
#
#* Special route '/contact_us' is provided.