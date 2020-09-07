require('rspec')
require('album')

describe('#Album') do
  before(:each) do
    Album.clear
  end

  it('initializes with reader attributes name, artist, year, genre, id') do
    name = "Flower Boy"
    artist = "Tyler the Creator"
    year = 2016
    genre = "Hip Hop"
    newAlbum = Album.new(name, artist, year, genre, nil)
    expect(newAlbum.name).to(eq(name))
    expect(newAlbum.artist).to(eq(artist))
    expect(newAlbum.year).to(eq(2016))
    expect(newAlbum.genre).to(eq("Hip Hop"))
    expect(newAlbum.id).to(eq(1)) # id increments on init
  end

  describe('.all') do
    it('is empty when no albums have been created') do
      expect(Album.all).to(eq([]))
    end
  end

  #describe('.clear') do
  #  it('clears albums from hash') do
  #    album = Album.new("Giant Steps", nil)
  #    album.save
  #    album2 = Album.new("Iowa", nil)
  #    album2.save
  #    Album.clear
  #    expect(Album.all).to(eq([]))
  #  end
  #end
#
  #describe('.find') do
  #  it('returns album by id') do
  #    album = Album.new("Roy & Diz", nil)
  #    album.save
  #    album2 = Album.new("Flower Boy", nil)
  #    album2.save
  #    expect(Album.find(album.id)).to(eq(album))
  #  end
  #end
#
  #describe('#==') do
  #  it('is the same if the attributes are the same') do
  #    album = Album.new("Blue", nil)
  #    album2 = Album.new("Blue", nil)
  #    expect(album).to(eq(album2))
  #  end
  #end
#
  #describe('#save') do
  #  it('saves an album to albums hash') do
  #    album = Album.new("Giant Steps", nil)
  #    album.save()
  #    album2 = Album.new("Blue", nil)
  #    album2.save()
  #    expect(Album.all).to(eq([album,album2]))
  #  end
  #end
#
  #describe('#update') do
  #  it('updates album name') do
  #    album = Album.new("Them Crooked Vultures", nil)
  #    album.save
  #    album.update("Zipper Down")
  #    album.save
  #    expect(album.name).to(eq("Zipper Down"))
  #    expect(Album.find(1)).to(eq(album))
  #  end
  #end
#
  #describe('#delete') do
  #  it('deletes an album by id') do
  #    album = Album.new("Holy Diver", nil)
  #    album.save
  #    album2 = Album.new("Emily's D+Evolution", nil)
  #    album2.save
  #    album.delete
  #    expect(Album.all).to(eq([album2]))
  #  end
  #end

end