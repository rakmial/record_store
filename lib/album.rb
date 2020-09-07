class Album
  attr_accessor :name, :artist, :year, :genre
  attr_reader :id
  
  # Class variables
  @@albums = {}
  @@total_rows = 0

  # Constructor
  def initialize name, artist, year, genre, id
    @name = name
    @artist = artist
    @year = year
    @genre = genre
    @id = id || @@total_rows += 1
  end

  # Class methods
  def self.all
    @@albums.values
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  # Instance methods
  def save
    @@albums[self.id] = Album.new(self.name, self.artist, self.year, self.genre, self.id)
  end

  def update(new_name, new_artist, new_year, new_genre)
    self.name = new_name
    self.artist = new_artist
    self.year = new_year
    self.genre = new_genre
    self.save
  end

  def delete
    @@albums.delete(self.id)
  end

  def ==(other_album)
    (self.name == other_album.name) &&
    (self.artist == other_album.artist) &&
    (self.year == other_album.year) &&
    (self.genre == other_album.genre)
  end

  def songs
    Song.find_by_album(self.id)
  end

end
