require "sinatra/base"

require File.expand_path("lib/songs")

class Application < Sinatra::Base
  get "/" do
    redirect_to_random_song
  end

  get "/:artist/:track" do
    haml :index
  end

  get "/submit" do
    haml :submit
  end

  get "/songs" do
    haml :songs
  end

  def redirect_to_random_song
    redirect next_random_song_url
  end

  def next_random_song_url
    random_song = Songs.all.sample
    random_song.url
  end

  def song
    Songs.all.find do |song|
      song.artist.slugify == params[:artist] &&
        song.track.slugify == params[:track]
    end
  end
end
