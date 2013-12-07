class SentimentFinder
  def self.happy_emoticons
    [':-)', ':)', '=)', ':D']
  end

  def self.sad_emoticons
    [':-)', ':)', '=)', ':D']
  end

  def self.emoticons
    happy_emoticons + sad_emoticons
  end

  def has_sentiment? text
    regex = Regexp.new(
      SentimentFinder.emoticons.map { |e| Regexp.escape e }.join('|')
    )

    regex =~ text
  end
end
