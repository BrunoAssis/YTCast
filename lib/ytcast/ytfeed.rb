require 'open-uri'
require 'open3'
require 'json'

class YTFeed
  attr_reader :playlist_id, :items

  def initialize(playlist_id)
    @playlist_id = playlist_id
    @internal_json = read_json
    @items = read_items
  end

  private
  def read_json
    api_key = "AIzaSyC7HMqZfMnmMMYFNugV8iPnxaKAhSQqr9M"
    url = "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=#{@playlist_id}&part=snippet&maxResults=50&key=#{api_key}"
    open(url) do |response|
      JSON.parse response.read
    end
  end

  def read_items
    @internal_json["items"].map { |item_json| YTFeedItem.new(item_json) }
  end
end
