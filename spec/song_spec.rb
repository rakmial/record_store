require 'spec_helper'
 
describe('#Song') do
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
    @song2_attributes = {:name => @song_name2, :album_id => @album2.id, :id => nil}
    @song2 = Song.new(@song2_attributes)
    @song2.save
  end

  it('initializes with accessor attributes name, album_id, and reader attr id') do
    expect(@song.name).to(eq(@song_name))
    expect(@song.album_id).to(eq(@album.id))
  end
    
  # Class methods ---

  describe('.clear') do
    it('clears albums from Postgres DB') do
      Song.clear
      expect(Song.all).to(eq([]))
    end
  end
  
  describe('.all') do
    it('returns an array of Song objects that have been saved') do
      expect(Song.all).to(eq([@song, @song2]))
    end
  end
   
  describe('.find') do
    it('returns song by id') do
      expect(Song.find(@song.id)).to(eq(@song))
      expect(Song.find(@song2.id)).to(eq(@song2))
    end
  end

#  describe('.find_by_album') do
#    it('finds an array of songs from album of album_id') do
#      expect(Song.find_by_album(@album.id)).to(eq([@song]))
#      #expect(Song.find_by_album(@album2.id)).to(eq([@song2]))
#    end
#  end
#
#  # Instance methods --- 
#
  describe('#save') do
    it('saves a song to Postgres DB') do
      song3_attributes = {:name => "Man Tap", :album_id => @album2.id, :id => nil}
      song3 = Song.new(song3_attributes)
      song3.save
      expect(Song.all).to(eq([@song,@song2,song3]))
    end
  end
#
#  describe('#update') do
#    it('updates album attributes') do
#      song3 = Song.new("Diamond Dogs", 3, nil)
#      song3.update(@song_name2, @album2.id)
#      song3.save
#      expect(song3.name).to(eq(@song_name2))
#      expect(song3.album_id).to(eq(@album2.id))
#      expect(Song.find(3)).to(eq(song3))
#    end
#  end
#
#  describe('#delete') do
#    it('deletes a song by id') do
#      @song.delete
#      expect(Song.all).to(eq([@song2]))
#    end
#  end
#  
  describe('#==') do
    it('is the same song if the attributes are the same, ignoring id') do
      identical_song = Song.new({:name => @song_name, :album_id => @album.id, :id => nil})
      expect(@song).to(eq(identical_song))
    end
  end

#  describe('#album') do
#    it('returns album object to which it belongs by id') do
#      expect(@song.album).to(eq(@album))
#    end
#  end
end 