class Song
  attr_reader :id
  attr_accessor :name, :album_id 
  
  # Class variables
  @@songs = {}
  @@total_rows = 0

  # Constructor
  def initialize name, album_id, id
    @name = name
    @album_id = album_id
    @id = id || @@total_rows += 1
  end
#
#  # Class methods
#  def self.all
#    @@albums.values
#  end
#
#  def self.clear
#    @@albums = {}
#    @@total_rows = 0
#  end
#
#  def self.find(id)
#    @@albums[id]
#  end
#
#  # Instance methods
#  def save
#    @@albums[self.id] = Album.new(self.name, self.artist, self.year, self.genre, self.id)
#  end
#
#  def update(new_name, new_artist, new_year, new_genre)
#    @name = new_name
#    @artist = new_artist
#    @year = new_year
#    @genre = new_genre
#  end
#
#  def delete
#    @@albums.delete(self.id)
#  end
#
#  def ==(other_album)
#    (self.name == other_album.name) &&
#    (self.artist == other_album.artist) &&
#    (self.year == other_album.year) &&
#    (self.genre == other_album.genre)
#  end
end
