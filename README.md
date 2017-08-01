# Scrapper

This gem is developed to get images and videos from web pages using phantomjs, which provides a headless browser to scrap.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'scrapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scrapper

## Usage

    scrapper = Scrapper::WatirScrapper.new
    
    WatirWebMiner.start(scrapper) do
      select_driver('phantomjs')
      add_driver_path("/DRIVER_PATH/phantomjs")
      add_timeout_limit(60)
      #user can provide comma separated multiple urls
      add_urls(urls)
      start_mining
    end

    scrapper.images
    scrapper.videos

## Future Enhancements

1. We are targetting to scrap Vimeo, Dailymotion and other leading video providers 
2. To provide support for firefox browser in headless mode as phantomjs is fast but have some limitations too.
3. To make this gem more accurate day by day.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/HenryMirror/scrapper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Scrapper project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/HenryMirror/scrapper/blob/master/CODE_OF_CONDUCT.md).
