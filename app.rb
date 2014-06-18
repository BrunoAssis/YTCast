require 'sinatra'

require 'rss'
require 'open-uri'
require 'pry'

require 'open3'

module YTExtension
  def video_url
    if @local_video_url == nil
      youtube_url = self.links.first.href
      stdin, stdout, stderr = Open3.popen3('youtube-dl', '-g', youtube_url)
      video_url = nil
      if video_url = stdout.gets
        video_url.chomp!
      end
      @local_video_url = video_url
    end
    @local_video_url
  end

  def video_duration
    # if @local_video_url == nil
    #   youtube_url = self.links.first.href
    #   stdin, stdout, stderr = Open3.popen3('youtube-dl', '-g', youtube_url)
    #   video_url = nil
    #   if video_url = stdout.gets
    #     video_url.chomp!
    #   end
    #   @local_video_url = video_url
    # end
    # @local_video_url
  end
end

class RSS::Atom::Feed::Entry
  include YTExtension
end

class YTFeed
  attr_accessor :playlist_id

  def initialize(playlist_id)
    @playlist_id = playlist_id
  end

  def get_rss
    url = "http://gdata.youtube.com/feeds/api/playlists/PL#{@playlist_id}"
    open(url) do |rss|
      RSS::Parser.parse(rss)
    end
  end
end

get '/' do
  "Please, access ytcast.com/{playlist_id}"
end

get '/:playlist_id' do
  response.headers['Content-Type'] = 'application/rss+xml; charset=UTF-8'
  #application/atom+xml
  #X4wzH6YPQH3x25S7U6zp56wTopd1YYEN

  #playlist_id = params[:playlist_id]
  playlist_id = "X4wzH6YPQH3x25S7U6zp56wTopd1YYEN"
  yt_feed = YTFeed.new(playlist_id)
  feed = yt_feed.get_rss

  erb :feed, locals: {feed: feed, playlist_id: playlist_id}
end