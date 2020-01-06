require 'rspec'
require 'album'
require('spec_helper')

describe '#Album' do

  # before(:each) do
  #   Album.clear()
  #   Song.clear()
  # end
  #
  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new({:name => "Blue",:id => nil})
      album2 = Album.new({:name => "Blue",:id => nil})
      expect(album).to(eq(album2))
    end
  end
  #
  describe('#update') do
    it("updates an album by id") do
      album = Album.new({:name => "Giant Steps", :id => nil})
      album.save()
      album.update("A Love Supreme")
      expect(album.name).to(eq("A Love Supreme"))
    end
  end
  #
  describe('#save') do
    it("saves an album") do
      album = Album.new({:name => "Giant Steps", :id => nil}) # nil added as second argument
      album.save()
      album2 = Album.new({:name => "Blue", :id => nil}) # nil added as second argument
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end

  describe('#delete') do
    it("deletes an album by id") do
      album = Album.new({:name => "Giant Steps", :id => nil})
      album.save()
      album2 = Album.new({:name => "Blue", :id => nil})
      album2.save()
      album.delete()
      expect(Album.all).to(eq([album2]))
    end
  end

  describe('#delete') do
  it("deletes all songs belonging to a deleted album") do
    album = Album.new({:name => "A Love Supreme", :id => nil})
    album.save()
    song = Song.new({:name => "Naima", :album_id => album.id, :id => nil})
    song.save()
    album.delete()
    expect(Song.find(song.id)).to(eq(nil))
  end
end

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('.clear') do
    it("clears all albums") do
      album = Album.new({:name => "Giant Steps", :id => nil})
      album.save()
      album2 = Album.new({:name => "Blue", :id => nil})
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new({:name => "Giant Steps", :id => nil})
      album.save()
      album2 = Album.new({:name => "Blue", :id => nil})
      album2.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  # describe('#songs') do
  #   it("returns an album's songs") do
  #     album = Album.new({:name => "Giant Steps", :id => nil})
  #     album.save()
  #     song = Song.new("Naima", album.id, nil)
  #     song.save()
  #     song2 = Song.new("Cousin Mary", album.id, nil)
  #     song2.save()
  #     expect(album.songs).to(eq([song, song2]))
  #   end
  # end

  # describe('.sort') do
  #   it("finds an album by id") do
  #   album2 = Album.new({:name => "ZZZ: The Album", :id => nil})
  #     album2.save()
  #   album = Album.new({:name => "AAA", :id => nil})
  #     album.save()
  #     # Album.all()
  #     expect(Album.sort('artist')).to(eq(album))
  #   end
  # end


  # describe('.search') do
  #   it("is capable of searching the albums list by name") do
  #     album = Album.new({:name => "Giant Steps", :id => nil})
  #     album.save()
  #     album2 = Album.new({:name => "Led Zeppelin II", :id => nil})
  #     album2.save()
  #     expect(Album.search('Led')).to(eq(album2))
  #   end
  # end

end
