class Posting < ActiveRecord::Base
  validates :url, format: { with: /http:\/\//i, message: "Not a valid URL" }
  validates :title, presence: true

  def match_preferences?(preferences)
    preferences.each do |preference|
      title_array = title.split(" ")
      return true if title_array.detect { |word| word =~ /#{preference}/i }
    end
    false
  end

  def valid_post?
    url =~ /http:\/\// && !title.blank? && !(url =~ /ycombinator/)
  end
end
