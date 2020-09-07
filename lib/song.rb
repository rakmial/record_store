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
  # Class methods
  def self.all
    @@songs.values
  end

  def self.clear
    @@songs = {}
    @@total_rows = 0
  end
#
  def self.find(id)
    @@songs[id]
  end
#
#  # Instance methods
  def save
    @@songs[self.id] = Song.new(self.name, self.album_id, self.id)
  end
#
#  def update(new_name, new_artist, new_year, new_genre)
#    @name = new_name
#    @artist = new_artist
#    @year = new_year
#    @genre = new_genre
#  end
#
#  def delete
#    @@songs.delete(self.id)
#  end
#
  def ==(other_song)
    (self.name == other_song.name) &&
    (self.album_id == other_song.album_id)
  end
end
