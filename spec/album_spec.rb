require('rspec')
require('album')

describe('#Album') do
  before(:each) do
    Album.clear
  end
  
  name = "Flower Boy"
  artist = "Tyler the Creator"
  year = 2016
  genre = "Hip Hop"

  name2 = "Longjohns Boots and a Belt"
  artist2 = "The Devil Makes Three"
  year2 = 2004
  genre2 = "Folk Rock"

  it('initializes with reader attributes name, artist, year, genre, id') do
    newAlbum = Album.new(name, artist, year, genre, nil)
    expect(newAlbum.name).to(eq(name))
    expect(newAlbum.artist).to(eq(artist))
    expect(newAlbum.year).to(eq(2016))
    expect(newAlbum.genre).to(eq("Hip Hop"))
    expect(newAlbum.id).to(eq(1)) # id increments on init
  end

  describe('#save') do
    it('saves an album to albums hash') do
      album = Album.new(name, artist, year, genre, nil)
      album.save()
      album2 = Album.new(name2, artist2, year2, genre2, nil)
      album2.save()
      expect(Album.all).to(eq([album,album2]))
    end
  end

  describe('#update') do
    it('updates album name') do
      album = Album.new(name, artist, year, genre, nil)
      album.save
      album.update(name2, artist2, year2, genre2)
      album.save
      expect(album.name).to(eq(name2))
      expect(album.artist).to(eq(artist2))
      expect(album.year).to(eq(year2))
      expect(album.genre).to(eq(genre2))
      expect(Album.find(1)).to(eq(album))
    end
  end

  describe('#delete') do
    it('deletes an album by id') do
      album = Album.new(name, artist, year, genre, nil)
      album.save
      album2 = Album.new(name2, artist2, year2, genre2, nil)
      album2.save
      album.delete
      expect(Album.all).to(eq([album2]))
    end
  end

  describe('.all') do
    it('is empty when no albums have been created') do
      expect(Album.all).to(eq([]))
    end
  end

  describe('.clear') do
    it('clears albums from hash') do
      album = Album.new(name, artist, year, genre, nil)
      album.save
      album2 = Album.new(name2, artist2, year2, genre2, nil)
      album2.save
      Album.clear
      expect(Album.all).to(eq([]))
    end
  end

  describe('.find') do
    it('returns album by id') do
      album = Album.new(name, artist, year, genre, nil)
      album.save
      album2 = Album.new(name2, artist2, year2, genre2, nil)
      album2.save
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  describe('#==') do
    it('is the same if the attributes are the same') do
      album = Album.new(name, artist, year, genre, nil)
      album2 = Album.new(name, artist, year, genre, nil)
      expect(album).to(eq(album2))
    end
  end
end