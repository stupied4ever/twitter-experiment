class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps

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

  private

  def twitter_user_regex
    /\s*(?<=^|(?<=[^a-zA-Z0-9\.]))@([A-Za-z]+[A-Za-z0-9]+)\s*/
  end
end
