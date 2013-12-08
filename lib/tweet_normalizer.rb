class TweetNormalizer
  def remove_accents tweet
    I18n.transliterate tweet.text
  end

  def remove_accents! tweet
    tweet.text = remove_accents tweet
  end

  def remove_users tweet
    tweet.text.gsub(twitter_user_regex, '')
  end

  def remove_users! tweet
    tweet.text = remove_users tweet
  end

  def remove_not_alphanumeric tweet
    tweet.text.gsub(/[^À-ÿ\w\s]/, ' ').gsub(/\s\s\s*/, ' ').strip
  end

  def remove_not_alphanumeric! tweet
    tweet.text = remove_not_alphanumeric tweet
  end

  def remove_emoticons tweet
    tweet.text.gsub SentimentFinder.all_emoticons_regex, ''
  end

  def remove_emoticons! tweet
    tweet.text = remove_emoticons tweet
  end

  def remove_rt tweet
    tweet.text.gsub(/(rt|RT)\s/, '')
  end

  def remove_rt! tweet
    tweet.text = remove_rt tweet
  end

  def normalize! tweet
    tweet.text.downcase!
    remove_emoticons! tweet
    remove_rt! tweet
    remove_accents! tweet
    remove_users! tweet
    remove_not_alphanumeric! tweet
  end

  private

  def twitter_user_regex
    /\s*(?<=^|(?<=[^a-zA-Z0-9\.]))@([A-Za-z]+[A-Za-z0-9]+)\s*/
  end
end
