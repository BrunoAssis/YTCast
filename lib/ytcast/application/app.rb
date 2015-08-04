require 'sinatra'
require 'ytcast'

class YTCastApp < Sinatra::Base
  set :views, File.expand_path('../views', __FILE__)

  get '/' do
    "Please, access ytcast.com/{playlist_id}"
  end

  get '/:playlist_id' do
    content_type :xml
    #response.headers['Content-Type'] = 'application/rss+xml; charset=UTF-8'
    #application/atom+xml
    #playlist_id = params[:playlist_id]
    playlist_id = "PLX4wzH6YPQH3x25S7U6zp56wTopd1YYEN"
    #https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails&maxResults=50&playlistId=PLX4wzH6YPQH3x25S7U6zp56wTopd1YYEN&key=AIzaSyC7HMqZfMnmMMYFNugV8iPnxaKAhSQqr9M
    yt_feed = YTCast::YTFeed.new(playlist_id)
    feed = yt_feed.get_JASON
    erb :feed, locals: {feed: feed, playlist_id: playlist_id}
  end
end

YTCastApp.run!
