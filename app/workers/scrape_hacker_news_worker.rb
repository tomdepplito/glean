class ScrapeHackerNewsWorker
  include Sidekiq::Worker

  def perform
    scraper = HackerNewsScraper.new
    scraper.process_postings # Scrape and create new postings
  end
end
