require 'sinatra'
require 'ytcast'

class YTCastApp < Sinatra::Base
  set :views, File.expand_path('../views', __FILE__)

  get '/' do
    "Please, access ytcast.com/{playlist_id}"
  end

  get '/:playlist_id' do
    content_type :xml
    #playlist_id = params[:playlist_id]
    playlist_id = "PLX4wzH6YPQH3x25S7U6zp56wTopd1YYEN"
    feed = YTFeed.new(playlist_id)
    erb :feed, locals: {feed: feed}
  end
end

YTCastApp.run!
