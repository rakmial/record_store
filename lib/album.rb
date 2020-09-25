class Album
  attr_accessor :name
  attr_reader :id

  # Constructor
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
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

  def self.search(search_term, option)
    case option
    when "name"
      @@albums.values.select {|a| a.name.include?(search_term)} 
    end
  end

  def self.sort(option)
    case option
    when "name"
      @@albums.values.sort_by(&:name)
    end
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
    self.name == other_album.name
  end

  def songs
    Song.find_by_album(self.id)
  end
end
