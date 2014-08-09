class HackerNewsScraper < PostingsScraper
  TARGET_URL = 'http://news.ycombinator.com'

  def page
    @page ||= retrieve_page
  end

  def retrieve_page(target_url = TARGET_URL)
    begin
      Timeout::timeout(3) do
        return HTTParty.get(TARGET_URL)
      end
    end
  end

  def process_postings
    if page && page.response.code == "200"
      Nokogiri::HTML(page).css('a').each do |scraped_post|
        title = scraped_post.children.last.content.downcase
        url = scraped_post.attributes['href'].value
        new_posting = Posting.new(title: title, url: url, source: self.class.to_s)
        if new_posting.valid_post?
          @preferences ||= Preference.get
          begin
            new_posting.save! if new_posting.match_preferences?(@preferences)
          rescue
          end
        end
      end
    end
  end
end
