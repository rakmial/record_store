class Artist
  attr_accessor :name
  attr_reader :id

  # Constructor
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  # Class methods
  def self.all
    pg_return = DB.exec("SELECT * FROM artists;")
    artists = []
    pg_return.each do |artist|
      name = artist.fetch("name")
      id = artist.fetch("id").to_i
      artists.push(Artist.new({:name => name, :id => id}))
    end
    artists
  end

  def self.clear
    DB.exec("DELETE FROM artists *;")
  end

  def self.find(id)
    artist = DB.exec("SELECT * FROM artists WHERE id = #{id};").first
    name = artist.fetch("name")
    id = artist.fetch("id").to_i
    Artist.new({:name => name, :id => id})
  end

  #def self.search(search_term, option)
  #  case option
  #  when "name"
  #    @@albums.values.select {|a| a.name.include?(search_term)} 
  #  end
  #end

  #def self.sort(option)
  #  case option
  #  when "name"
  #    @@albums.values.sort_by(&:name)
  #  end
  #end

  # Instance methods
  def save
    result = DB.exec("INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def update(updated_attrs)
    if updated_attrs[:name]
      @name = updated_attrs[:name]
      DB.exec("UPDATE artists SET name = '#{@name}' WHERE id = #{@id};")
    end
    if (album_name = updated_attrs[:album_name]) && album = DB.exec("\
      SELECT * FROM albums \
      WHERE lower(name) = '#{album_name.downcase}';")
      .first
      DB.exec("\
        INSERT INTO albums_artists (album_id, artist_id) \
        VALUES (#{album['id'].to_i}, #{@id});")
    end
  end

  def delete
    DB.exec("DELETE FROM albums_artists WHERE artist_id = #{@id};")
    DB.exec("DELETE FROM artists WHERE id = #{@id};")
  end

  def ==(other_artist)
    self.name == other_artist.name
  end

  def albums
    pg_return = DB.exec("\
      SELECT * FROM albums_artists \
      WHERE artist_id = #{@id}")
    album_ids = []
    pg_return.each do |assoc|
      album_ids.push(assoc["album_id"].to_i)
    end
    albums = []
    album_ids.each do |album_id|
      album = DB.exec("\
        SELECT * FROM albums
        WHERE id = #{album_id};").first
      albums.push(
        Album.new({
          :name => album["name"], 
          :id => album["id"].to_i}))
    end
    albums
  end

end
