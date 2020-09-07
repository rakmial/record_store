class Album
  attr_reader :name, :artist, :year, :genre, :id
  
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

  def update(new_name)
    @name = new_name
  end

  def delete
    @@albums.delete(self.id)
  end

  #def ==(other_album)
  #  self.name == other_album.name
  #end
end
