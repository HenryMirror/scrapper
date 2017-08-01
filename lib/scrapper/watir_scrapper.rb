require_relative 'browser'
require_relative 'helpers'

module Scrapper
  class WatirScrapper
    include Scrapper::Helpers

    attr_accessor :images, :videos
    attr_reader :browser, :driver_path, :driver, :timeout_limit, :urls

    def initialize
      @browser = nil
      @driver_path = nil
      @driver = nil
      @timeout_limit = nil
      @urls = nil
      @images = []
      @videos = []
    end

    def select_driver(driver)
      @driver = driver
    end

    def add_driver_path(path)
      @driver_path = path
    end

    def add_timeout_limit(limit)
      @timeout_limit = limit
    end

    def add_urls(urls)
      @urls = split_urls(urls)
    end

    def start_mining
      @browser = Scrapper::Browser.get_browser(@driver_path, @timeout_limit)
      mine_content
    end

    def mine_content
      @urls.each do |url|
        if youtube_url?(url)
          fetch_youtube_content(url, @browser)
          next 
        end
        @browser.goto(url)
        fetch_images
        fetch_videos  
      end
    rescue StandardError => e
      log_error(e)
    ensure
      @browser.close
    end

    private

    def youtube_url?(url)
      ((url.scan(Scrapper::Constants::YOUTUBE_USER_URL_REGEX).present?) || (url.scan(Scrapper::Constants::YOUTUBE_CHANNEL_URL_REGEX).present?))
    end

    def fetch_youtube_content(url, browser)
      url = url.ends_with?('videos') ? url : "#{url}/videos"
      youtube = YoutubeScrapper.new
      youtube.mine_content(url, browser)
      @images += youtube.images.uniq!
      @videos += youtube.videos.uniq!
    end

    def fetch_images
      @images += browser.images.to_a.collect(&:src)
    end

    def fetch_videos
      @videos += browser.videos.to_a.collect do |v|
                  if v.src.present?
                    v.src
                  elsif (v.source.src.present? rescue nil)
                    v.source.src
                  end
                end
      @videos += videos_from_link
      @videos += videos_from_iframes
      add_src_to_videos
      @videos.uniq!
    end

    def videos_from_link
      links = browser.links.to_a.collect(&:href)
      links.select {|l| l.scan(Scrapper::Constants::YOUTUBE_EMBED_URL_REGEX).present? || (l.include?'vimeo')}
    end

    def videos_from_iframes
      iframes = browser.iframes.to_a.collect(&:src)
      iframes.select {|f| f.scan(Scrapper::Constants::YOUTUBE_EMBED_URL_REGEX).present? || (f.include?'vimeo')}
    end

  end
end