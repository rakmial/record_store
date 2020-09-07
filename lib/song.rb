require('pry')

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

  # Class methods
  def self.all
    @@songs.values
  end

  def self.clear
    @@songs = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@songs[id]
  end

  def self.find_by_album(alb_id)
    songs = []
    @@songs.values.each do |song|
      songs.push(song) if song.album_id == alb_id
    end
    songs
  end

  # Instance methods
  def save
    @@songs[self.id] = Song.new(self.name, self.album_id, self.id)
  end

  def update(new_name, new_album_id)
    self.name = new_name
    self.album_id = new_album_id
    self.save
  end

  def delete
    @@songs.delete(self.id)
  end

  def ==(other_song)
    (self.name == other_song.name) &&
    (self.album_id == other_song.album_id)
  end
end
