class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps

  scope :trainable_objects, where(trainable: true)

  scope :happy, where(text: SentimentFinder.happy_regex)
  scope :sad, where(text: SentimentFinder.sad_regex)

  field :favorite_count,          type: Integer
  field :favorited,               type: Boolean
  field :in_reply_to_screen_name
  field :in_reply_to_attrs_id
  field :in_reply_to_status_id
  field :in_reply_to_user_id
  field :lang
  field :retweet_count,           type: Integer
  field :retweeted,               type: Boolean
  field :source
  field :text
  field :truncated,               type: Boolean
  field :trainable,               type: Boolean

  index( { trainable: 1 } )

  def self.from object
    tweet = ::Tweet.new
    tweet.favorite_count          = object.favorite_count
    tweet.favorited               = object.favorited
    tweet.in_reply_to_screen_name = object.in_reply_to_screen_name
    tweet.in_reply_to_attrs_id    = object.in_reply_to_attrs_id
    tweet.in_reply_to_status_id   = object.in_reply_to_status_id
    tweet.in_reply_to_user_id     = object.in_reply_to_user_id
    tweet.lang                    = object.lang
    tweet.retweet_count           = object.retweet_count
    tweet.retweeted               = object.retweeted
    tweet.source                  = object.source
    tweet.text                    = object.text
    tweet.truncated               = object.truncated
    tweet
  end

  def remove_accents
    I18n.transliterate text
  end

  def remove_accents!
    self.text = remove_accents
  end

  def remove_users
    self.text.gsub(twitter_user_regex, '')
  end

  def remove_users!
    self.text = remove_users
  end

  def remove_not_alphanumeric
    text.gsub!(/[^À-ÿ\w\s]/, ' ').gsub(/\s\s\s*/, ' ').strip
  end

  def remove_not_alphanumeric!
    self.text = remove_not_alphanumeric
  end

  def remove_emoticons
    self.text.gsub SentimentFinder.all_emoticons_regex, ''
  end

  def remove_emoticons!
    self.text = remove_emoticons
  end

  def remove_rt
    self.text.gsub(/(rt|RT)\s/, '')
  end

  def remove_rt!
    self.text = remove_rt
  end

  def normalize!
    self.text = text.downcase
    remove_emoticons!
    remove_rt!
    remove_accents!
    remove_users!
    remove_not_alphanumeric!
  end

  def trainable_sentiment
    sentiments = Array.new
    sentiments << :happy if SentimentFinder.happy_regex =~ text
    sentiments << :sad   if SentimentFinder.sad_regex   =~ text

    sentiments
  end

  def train classifier
    if (sentiment = trainable_sentiment).size == 1
      normalize!
      classifier.train sentiment.first, text
    end
  end

  def is_trainable?
    trainable_sentiment.size  == 1
  end

  private

  def twitter_user_regex
    /\s*(?<=^|(?<=[^a-zA-Z0-9\.]))@([A-Za-z]+[A-Za-z0-9]+)\s*/
  end
end
