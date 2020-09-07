#require('rspec')
#require('song')
#require('album')
#require('pry')

#describe('#Album') do
#  before(:each) do
#    Album.clear
#    @name = "Flower Boy"
#    @artist = "Tyler the Creator"
#    @year = 2016
#    @genre = "Hip Hop"
#    @album = Album.new(@name, @artist, @year, @genre, nil)
#    @album.save
#    
#    @name2 = "Longjohns Boots and a Belt"
#    @artist2 = "The Devil Makes Three"
#    @year2 = 2004
#    @genre2 = "Folk Rock"
#    @album2 = Album.new(@name2, @artist2, @year2, @genre2, nil)
#    @album2.save
#  end
#  
#
#  it('initializes with reader attributes name, artist, year, genre, id') do
#    expect(@album.name).to(eq(@name))
#    expect(@album.artist).to(eq(@artist))
#    expect(@album.year).to(eq(@year))
#    expect(@album.genre).to(eq(@genre))
#    expect(@album.id).to(eq(1)) # id increments on init
#    expect(@album2.id).to(eq(2))
#  end
#
#  describe('#save') do
#    it('saves an album to albums hash') do
#      album3 = Album.new("Diamond Dogs", "David Bowie", 1974, "Rock", nil)
#      expect(Album.all).to(eq([@album,@album2,album3]))
#    end
#  end
#
#  describe('#update') do
#    it('updates album attributes') do
#      @album.update(@name2, @artist2, @year2, @genre2)
#      expect(@album.name).to(eq(@name2))
#      expect(@album.artist).to(eq(@artist2))
#      expect(@album.year).to(eq(@year2))
#      expect(@album.genre).to(eq(@genre2))
#      expect(Album.find(1)).to(eq(@album))
#    end
#  end
#
#  describe('#delete') do
#    it('deletes an album by id') do
#      @album.delete
#      expect(Album.all).to(eq([@album2]))
#    end
#  end
#  
#  describe('#==') do
#    it('is the same album if the attributes are the same, ignoring id') do
#      identical_album = Album.new(@name, @artist, @year, @genre, nil)
#      expect(@album).to(eq(identical_album))
#    end
#  end
#
#  describe('.clear') do
#    it('clears albums from hash') do
#      Album.clear
#      expect(Album.all).to(eq([]))
#    end
#  end
#  
#  describe('.all') do
#    it('is empty when no albums have been created or after .clear') do
#      Album.clear
#      expect(Album.all).to(eq([]))
#    end
#  end
#
#  describe('.all') do
#    it('returns an array of Album objects that have been saved') do
#      expect(Album.all).to(eq([@album, @album2]))
#    end
#  end
#
#  describe('.find') do
#    it('returns album by id') do
#      expect(Album.find(@album.id)).to(eq(@album))
#      expect(Album.find(@album2.id)).to(eq(@album2))
#    end
#  end
#end