class TweetNormalizer
  def remove_accents text
    I18n.transliterate text
  end

  def remove_users text
    text.gsub(twitter_user_regex, '')
  end

  def remove_not_alphanumeric text
    text.gsub(/[^À-ÿ\w\s]/, ' ').gsub(/\s\s\s*/, ' ').strip
  end

  def remove_emoticons text
    text.gsub SentimentFinder.all_emoticons_regex, ''
  end

  def remove_rt text
    text.gsub(/(rt|RT)\s/, '')
  end

  def normalize text
    text = remove_emoticons text.downcase
    text = remove_accents text.dup
    text = remove_users text
    text = remove_rt text
    text = remove_not_alphanumeric text
    text
  end

  private

  def twitter_user_regex
    /\s*(?<=^|(?<=[^a-zA-Z0-9\.]))@([A-Za-z]+[A-Za-z0-9]+)\s*/
  end
end
