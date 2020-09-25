require 'spec_helper'

describe('#Album') do
  before(:each) do
    @name = "Flower Boy"
    @album_attributes = {:name => @name, :id => nil}
    @album = Album.new(@album_attributes)
    @album.save
    @song_name = "Garden Shed"
    @song_attributes = {:name => @song_name, :album_id => @album.id, :id => nil}
    @song = Song.new(@song_attributes)
    @song.save
    
    @name2 = "Longjohns Boots and a Belt"
    @album2_attributes = {:name => @name2, :id => nil}
    @album2 = Album.new(@album2_attributes)
    @album2.save
    @song_name2 = "Never Learn"
    @song2_attriburtes = {:name => @song_name2, :album_id => @album2.id, :id => nil}
    @song2 = Song.new(@song2_attriburtes)
    @song2.save
  end
  
  # Instance methods ---

  describe('#save') do
    it('saves an album to PostgreSQL database') do
      album3 = Album.new({:name => "Diamond Dogs", :id => nil})
      album3.save
      expect(Album.all).to(eq([@album, @album2, album3]))
    end
  end
#
  describe('#update') do
    it('updates album attributes') do
      album3 = Album.new({:name => "Diamond Dogs", :id => nil})
      album3.save
      album3.update(@name2)
      expect(album3.name).to(eq(@name2))
      expect(Album.find(album3.id)).to(eq(album3))
    end
  end

  describe('#delete') do
    it('deletes an album and associated songs by id') do
      @album.delete
      expect(Album.all).to(eq([@album2]))
      expect(Song.find(@song.id)).to(eq(nil))
    end
  end
  
  describe('#==') do
    it('is the same album if the attributes are the same, ignoring id') do
      identical_album = Album.new(@album_attributes)
      expect(@album).to(eq(identical_album))
    end
  end

  describe('#songs') do
    it('returns an array of songs on the album') do
      expect(@album.songs).to(eq([@song]))
    end
  end


  # Class methods

  describe('.clear') do
    it('clears albums from hash') do
      Album.clear
      expect(Album.all).to(eq([]))
    end
  end
  
  describe('.all') do
    it('is empty when no albums have been created or after .clear') do
      Album.clear
      expect(Album.all).to(eq([]))
    end
    it('returns an array of Album objects that have been saved') do
      expect(Album.all).to(eq([@album, @album2]))
    end
  end
#
  describe('.find') do
    it('returns album by id') do
      expect(Album.find(@album.id)).to(eq(@album))
    end
  end
#
#  describe('.search') do
#    it('returns array of albums with name, artist, year, or genre \
#      containing search term') do
#      expect(Album.search("Flower", "name")).to(eq([@album]))
#      expect(Album.search("The Devil Makes Three", "artist")).to(eq([@album2]))
#      expect(Album.search("20", "year")).to(eq([@album,@album2]))
#      expect(Album.search("Hip Hop", "genre")).to(eq([@album]))
#      expect(Album.search("country", "genre")).to(eq([]))
#    end
#  end
#
end