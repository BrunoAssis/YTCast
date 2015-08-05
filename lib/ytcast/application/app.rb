require 'sinatra'
require 'ytcast'

class YTCastApp < Sinatra::Base
  set :bind, '0.0.0.0'
  set :views, File.expand_path('../views', __FILE__)

  get '/' do
    "Please, access ytcast.com/{playlist_id}"
  end

  get '/:playlist_id' do
    content_type :xml
    playlist_id = params[:playlist_id]
    feed = YTFeed.new(playlist_id)
    erb :feed, locals: {feed: feed}
  end
end

YTCastApp.run!
