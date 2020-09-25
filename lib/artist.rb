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

  def update(new_name)
    self.name = new_name
    DB.exec("UPDATE artists SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM artists WHERE id = #{@id};")
  end

  def ==(other_artist)
    self.name == other_artist.name
  end

end
