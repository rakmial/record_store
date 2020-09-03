require('rspec')
require('album')

describe('#Album') do
  before(:each) do
    Album.clear
  end

  describe('.all') do
    it('is empty when no albums have been created') do
      expect(Album.all).to(eq([]))
    end
  end

  describe('.clear') do
    it('clears albums from hash') do
      album = Album.new("Giant Steps", nil)
      album.save
      album2 = Album.new("Iowa", nil)
      album2.save
      Album.clear
      expect(Album.all).to(eq([]))
    end
  end

  describe('.find') do
    it('returns album by id') do
      album = Album.new("Roy & Diz", nil)
      album.save
      album2 = Album.new("Flower Boy", nil)
      album2.save
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  describe('#==') do
    it('is the same if the attributes are the same') do
      album = Album.new("Blue", nil)
      album2 = Album.new("Blue", nil)
      expect(album).to(eq(album2))
    end
  end

  describe('#save') do
    it('saves an album to albums hash') do
      album = Album.new("Giant Steps", nil)
      album.save()
      album2 = Album.new("Blue", nil)
      album2.save()
      expect(Album.all).to(eq([album,album2]))
    end
  end

end