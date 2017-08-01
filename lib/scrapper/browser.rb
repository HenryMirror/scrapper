module Scrapper
  class Browser

    def self.get_browser(driver_path, timeout)
      Selenium::WebDriver::PhantomJS.path = driver_path
      Watir.default_timeout = timeout 
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.read_timeout, client.open_timeout = timeout, timeout
      args = %w{--ignore-ssl-errors=true}
      Watir::Browser.new :phantomjs, http_client: client, args: args
    end

  end
end