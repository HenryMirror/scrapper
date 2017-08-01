module Scrapper
  module Helpers

    def add_src_to_videos
      self.videos.collect! do |v| 
        {src: v, type: 'video_from_src'}
      end
    end

    def get_logger(logger_path=nil)
      @@logger ||= Logger.new(logger_path.present? ? logger_path : "#{Rails.root}/log/scrapper.log")
    end

    def log_error(e)
      get_logger.error "Error in #{self.class} for Urls #{@urls} due to #{e.message} #{e.backtrace}"
    end
    
    def split_urls(urls)
      urls.split("\n").map(&:strip)
    end

  end
end