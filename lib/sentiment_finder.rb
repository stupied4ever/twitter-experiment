class SentimentFinder
  def self.happy_emoticons
    [':-)', ':)', '=)', ':D']
  end

  def self.sad_emoticons
    [':-(', ':(', '=(', ';(']
  end

  def self.emoticons
    happy_emoticons + sad_emoticons
  end

  def self.happy_regex
    generate_regex happy_emoticons
  end

  def self.sad_regex
    generate_regex sad_emoticons
  end

  def has_sentiment? text
    regex = SentimentFinder.generate_regex(SentimentFinder.emoticons)
    regex =~ text
  end

  private

  def self.generate_regex emoticons
    Regexp.new(
      emoticons.map { |e| Regexp.escape e }.join('|')
    )
  end
end
