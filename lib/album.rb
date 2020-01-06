class Album
  attr_reader :name
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id) # Note that this line has been changed.
  end

  def update(name)
    @name = name
    DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
  end

  def save
    result = DB.exec("INSERT INTO albums (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name() && self.id() == album_to_compare.id()
  end

  def self.all
    returned_albums = DB.exec("SELECT * FROM albums;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      id = album.fetch("id").to_i
      albums.push(Album.new({:name => name, :id => id}))
    end
    albums
  end

  def self.get_sold
    @@sold_albums.values()
  end

  # def self.all2
  #   return @@albums
  # end

  def self.clear
    DB.exec("DELETE FROM albums *;")
  end

  def self.find(id)
    album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
    name = album.fetch("name")
    id = album.fetch("id").to_i
    Album.new({:name => name, :id => id})
  end

  def self.search(string)
    @@albums.values().select {|e| /#{string}/i.match(e.name) }
  end

  # def self.sort(input)
  #   # @@albums.sort_by {|e| input.match(e.name) }
  #   if input == 'artist'
  #     @@albums.values().sort{ |a, b| a.artist <=> b.artist }
  #   elsif input == 'name'
  #     @@albums.values().sort{ |a, b| a.name <=> b.name }
  #   end
  # end

  def delete
    DB.exec("DELETE FROM albums WHERE id = #{@id};")
    DB.exec("DELETE FROM songs WHERE album_id = #{@id};") # new code
  end

  def buy_album
      @@sold_albums[self.id] = @@albums[self.id]
      @@albums.delete(self.id)
  end

  def songs
    # binding.pry
   Song.find_by_album(self.id)
  end

end
