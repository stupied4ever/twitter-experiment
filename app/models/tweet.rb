class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps

  scope :trainable, where(trainable: true).ne(trainned: true)

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
  field :trainned,                type: Boolean

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

  def trainable_sentiment
    sentiments = Array.new
    sentiments << :happy if SentimentFinder.happy_regex =~ text
    sentiments << :sad   if SentimentFinder.sad_regex   =~ text

    sentiments
  end

  def train! classifier
    if (sentiment = trainable_sentiment).size == 1
      normalize!
      classifier.send(
        "train_#{ sentiment.first.to_s }", text
      )
      update trainned: true
    end
  end

  def is_trainable?
    trainable_sentiment.size  == 1
  end
end
