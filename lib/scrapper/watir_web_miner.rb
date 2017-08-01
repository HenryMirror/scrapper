class WatirWebMiner

  def self.start(scrapper, &block)
    scrapper.instance_eval &block
  end

end