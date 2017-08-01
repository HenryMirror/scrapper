require_relative 'helpers'

module Scrapper
  class YoutubeScrapper
    include Scrapper::Helpers

    attr_accessor :images, :videos
    
    def initialize
      @images = []
      @videos = []
    end 
    
    def mine_content(url,browser)
      browser.goto(url)
      fetch_images(browser)
      fetch_videos(browser)
    rescue StandardError => e
      log_error(e)
    end

    def fetch_videos(browser)
      @videos += browser.links.to_a.collect(&:href).collect do |l|
                   next unless l.scan(Scrapper::Constants::YOUTUBE_WATCH_URL_REGEX).present?
                   "https://www.youtube.com/embed/#{l.split('v=').last}"
                 end
      @videos.compact!
      add_src_to_videos
      #TODO::Could be used to load more videos from youtube
      #browser.span(class: "load-more-text").click
    end

    def fetch_images(browser)
      @images += browser.images.to_a.collect(&:src)
    end

  end
end