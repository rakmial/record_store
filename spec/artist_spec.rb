require 'spec_helper'

describe('#Artist') do
  before(:each) do
    @name = "Tyler, the Creator"
    @artist_attributes = {:name => @name, :id => nil}
    @artist = Artist.new(@artist_attributes)
    @artist.save
    
    @name2 = "The Devil Makes Three"
    @artist2_attributes = {:name => @name2, :id => nil}
    @artist2 = Artist.new(@artist2_attributes)
    @artist2.save
  end
  
  # Instance methods ---

  describe('#save') do
    it('saves an artist to PostgreSQL database') do
      artist3 = Artist.new({:name => "David Bowie", :id => nil})
      artist3.save
      expect(Artist.all).to(eq([@artist, @artist2, artist3]))
    end
  end
#
  describe('#update') do
    it('updates artist attributes') do
      artist3 = Artist.new({:name => "David Bowie", :id => nil})
      artist3.save
      artist3.update({:name => @name2})
      expect(artist3.name).to(eq(@name2))
      expect(Artist.find(artist3.id)).to(eq(artist3))
    end
    it('associates new albums to artists') do
      album = Album.new({:name => "Flower Boy", :id => nil})
      album.save
      @artist.update({:album_name => "Flower Boy"})
      expect(@artist.albums).to(eq([album]))
    end
  end

  describe('#delete') do
    it('deletes an artist by id') do
      @artist.delete
      expect(Artist.all).to(eq([@artist2]))
    end
  end
  
  describe('#==') do
    it('is the same artist if the attributes are the same, ignoring id') do
      identical_artist = Artist.new(@artist_attributes)
      expect(@artist).to(eq(identical_artist))
    end
  end

  # Class methods

  describe('.clear') do
    it('deletes all artists from Postgres DB') do
      Artist.clear
      expect(Artist.all).to(eq([]))
    end
  end
  
  describe('.all') do
    it('returns an array of Artist objects that have been saved') do
      expect(Artist.all).to(eq([@artist, @artist2]))
    end
  end
#
  describe('.find') do
    it('returns artist by id') do
      expect(Artist.find(@artist.id)).to(eq(@artist))
    end
  end
#
#  describe('.search') do
#    it('returns array of artists with name, artist, year, or genre \
#      containing search term') do
#      expect(Artist.search("Flower", "name")).to(eq([@artist]))
#      expect(Artist.search("The Devil Makes Three", "artist")).to(eq([@artist2]))
#      expect(Artist.search("20", "year")).to(eq([@artist,@artist2]))
#      expect(Artist.search("Hip Hop", "genre")).to(eq([@artist]))
#      expect(Artist.search("country", "genre")).to(eq([]))
#    end
#  end
#
end