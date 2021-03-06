require 'pry'
class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = self.new
    song.save
    song
  end

  def self.new_by_name(song_name)
    song = self.create
    song.name = song_name
    song
  end

  def self.create_by_name(song_name)
    song = self.create #Calling .create method creates a new instance of Song, also saves it into @@all.
    song.name = song_name
    song
  end

  def self.find_by_name(song_name)
    self.all.find {|song| song.name == song_name}
  end

  def self.find_or_create_by_name(song_name)
    # refactoring
    self.find_by_name(song_name) || self.create_by_name(song_name)

    # original attempt: if the song instance already exists, return it
    # if not, create the new song instance and return it
    # if self.find_by_name(song_name)
    #   self.find_by_name(song_name)
    # else self.create_by_name(song_name)
    # end
  end

  def self.alphabetical
    self.all.sort_by {|a| a.name }
  end

  def self.new_from_filename(file_name)
    split_file = file_name.split(/[-.]/)
    artist = split_file[0].strip
    song_name = split_file[1].strip

    song = Song.new
    song.name = song_name
    song.artist_name = artist

    song
  end

  def self.create_from_filename(file_name)
    self.all << self.new_from_filename(file_name)
  end

  def self.destroy_all
    self.all.clear
  end
end
