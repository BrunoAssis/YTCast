require "ytcast/version"
require "ytcast/ytfeed"
require "ytcast/ytfeeditem"

module YTCast
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
end
