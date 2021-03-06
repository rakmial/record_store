require('pry')

class Song
  attr_reader :id
  attr_accessor :name, :album_id 

  # Constructor
  def initialize attributes
    @name = attributes.fetch(:name)
    @album_id = attributes.fetch(:album_id)
    @id = attributes.fetch(:id)
  end

  # Class methods
  def self.all
    pg_return = DB.exec("SELECT * FROM songs;")
    songs = []
    pg_return.each do |song|
      name = song.fetch("name")
      album_id = song.fetch("album_id").to_i
      id = song.fetch("id").to_i
      songs.push(Song.new(:name => name, :album_id => album_id, :id => id))
    end
    songs
  end

  def self.clear
    DB.exec("DELETE FROM songs *;")
  end

  def self.find(id)
    pg_return = DB.exec("SELECT * FROM songs WHERE id = #{id};").first
    if pg_return
      name = pg_return.fetch("name")
      alb_id = pg_return.fetch("album_id").to_i
      id = pg_return.fetch("id").to_i
      Song.new({:name => name, :album_id => alb_id, :id => id})
    else
      nil
    end
  end

  def self.find_by_album(alb_id)
    pg_return = DB.exec("\
      SELECT * FROM songs \
      WHERE album_id = #{alb_id};")
    songs = []
    pg_return.each do |song|
      name = song.fetch("name")
      id = song.fetch("id").to_i
      songs.push(Song.new({:name => name, :album_id => alb_id, :id => id}))
    end
    songs
  end

  # Instance methods
  def save
    @id = DB.exec("INSERT INTO songs (name, album_id) \
      VALUES ('#{@name}', #{@album_id}) RETURNING id;")
      .first.fetch("id").to_i
  end

  def update(new_name, new_album_id)
    @name = new_name
    @album_id = new_album_id
    DB.exec("\
      UPDATE songs \
      SET name = '#{@name}', album_id = #{@album_id} \
      WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM songs WHERE id = #{@id};")
  end

  def ==(other_song)
    if other_song
      (self.name == other_song.name) &&
      (self.album_id == other_song.album_id)
    else
      false
    end
  end

  def album
    Album.find(self.album_id)
  end
end
