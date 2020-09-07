require('rspec')
require('song')
require('album')
require('pry')
 
describe('#Song') do

  before(:each) do
    Album.clear
    Song.clear
    @name = "Flower Boy"
    @artist = "Tyler the Creator"
    @year = 2016
    @genre = "Hip Hop"
    @album = Album.new(@name, @artist, @year, @genre, nil)
    @album.save
    @song_name = "Garden Shed"
    @song = Song.new(@song_name, @album.id, nil)
    @song.save
    
    @name2 = "Longjohns Boots and a Belt"
    @artist2 = "The Devil Makes Three"
    @year2 = 2004
    @genre2 = "Folk Rock"
    @album2 = Album.new(@name2, @artist2, @year2, @genre2, nil)
    @album2.save
    @song_name2 = "Never Learn"
    @song2 = Song.new(@song_name2, @album2.id, nil)
    @song2.save
  end

  it('initializes with accessor attributes name, album_id, and reader attr id') do
    expect(@song.name).to(eq(@song_name))
    expect(@song.album_id).to(eq(@album.id))
    expect(@song.id).to(eq(1)) # id increments on init
    expect(@song2.id).to(eq(2))
  end
    
  describe('.clear') do
    it('clears albums from hash') do
      Song.clear
      expect(Song.all).to(eq([]))
    end
  end

  describe('.all') do
    it('is empty when no songs have been created or after .clear') do
      Song.clear
      expect(Song.all).to(eq([]))
    end
  end
  
  describe('.all') do
    it('returns an array of Song objects that have been saved') do
      expect(Song.all).to(eq([@song, @song2]))
    end
  end

  describe('#save') do
    it('saves a song to songs hash') do
      song3 = Song.new("Man Tap", @album2.id, nil)
      song3.save
      expect(Song.all).to(eq([@song,@song2,song3]))
    end
  end
# 
#   describe('#update') do
#     it('updates album attributes') do
#       album3 = Song.new("Diamond Dogs", "David Bowie", 1974, "Rock", nil)
#       album3.update(@name2, @artist2, @year2, @genre2)
#       album3.save
#       expect(album3.name).to(eq(@name2))
#       expect(album3.artist).to(eq(@artist2))
#       expect(album3.year).to(eq(@year2))
#       expect(album3.genre).to(eq(@genre2))
#       expect(Song.find(3)).to(eq(album3))
#     end
#   end
# 
  describe('#delete') do
    it('deletes a song by id') do
      @song.delete
      expect(Song.all).to(eq([@song2]))
    end
  end
  
  describe('#==') do
    it('is the same song if the attributes are the same, ignoring id') do
      identical_song = Song.new(@song_name, @album.id, nil)
      expect(@song).to(eq(identical_song))
    end
  end
# 
  describe('.find') do
    it('returns song by id') do
      expect(Song.find(@song.id)).to(eq(@song))
      expect(Song.find(@song2.id)).to(eq(@song2))
    end
  end
end 