require 'cgi'

class YTFeedItem
  attr_reader :title, :description, :video_id, :thumbnail, :published_at

  def initialize(item_json)
    @internal_json = item_json
    @local_video_url = nil
    parse_json
  end

  def video_url
    if @local_video_url == nil
      chosen_format = choose_format
      video_url = get_video_url(chosen_format)
      @local_video_url = video_url
    end
    @local_video_url
  end

  private
  def parse_json
    @title = @internal_json["snippet"]["title"]
    @description = @internal_json["snippet"]["description"]
    @video_id = @internal_json["snippet"]["resourceId"]["videoId"]
    @thumbnail = @internal_json["snippet"]["thumbnails"]["standard"]
    @published_at = @internal_json["snippet"]["publishedAt"]
  end

  def choose_format
    chosen_format = nil
    stdin, stdout, stderr = Open3.popen3('youtube-dl', '-F', @video_id)
    stdout.each_line do |line|
      if line =~ /\(best\)/
        chosen_format = line.match(/^\d+/).to_s
        break
      end
    end
    chosen_format
  end

  def get_video_url(chosen_format)
    stdin, stdout, stderr = Open3.popen3('youtube-dl', '-g', @video_id, '-f', chosen_format)
    CGI.escapeHTML stdout.gets.chomp!
  end
end
