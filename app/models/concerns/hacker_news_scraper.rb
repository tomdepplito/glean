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
    if page.try(:response).try(:code) == "200"
      Nokogiri::HTML(page).css('a').each do |scraped_post|
        title = scraped_post.children.last.content
        url = scraped_post.attributes['href'].value
        new_posting = Posting.new(title: title, url: url)
        if new_posting.save!
          article = retrieve_page(url)
          new_posting.body = article
        end
      end
    end
  end

  def create_tags(article)
  end
end
