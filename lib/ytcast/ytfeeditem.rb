class YTFeedItem
  attr_reader :title, :description, :video_id, :thumbnail

  def initialize(item_json)
    @internal_json = item_json
    parse_json
  end

  private
  def parse_json
    @title = @internal_json["snippet"]["title"]
    @description = @internal_json["snippet"]["description"]
    @video_id = @internal_json["snippet"]["resourceId"]["videoId"]
    @thumbnail = @internal_json["snippet"]["thumbnails"]["standard"]
  end
end
