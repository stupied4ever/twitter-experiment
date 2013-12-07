module Streams
  class Forest
    def initialize twitter_client = twitter_client
      @twitter_client = twitter_client
    end

    def run
      @twitter_client.sample(language: 'pt') do |t|
        tweet = ::Tweet.new
        tweet.favorite_count          = t.favorite_count
        tweet.favorited               = t.favorited
        tweet.in_reply_to_screen_name = t.in_reply_to_screen_name
        tweet.in_reply_to_attrs_id    = t.in_reply_to_attrs_id
        tweet.in_reply_to_status_id   = t.in_reply_to_status_id
        tweet.in_reply_to_user_id     = t.in_reply_to_user_id
        tweet.lang                    = t.lang
        tweet.retweet_count           = t.retweet_count
        tweet.retweeted               = t.retweeted
        tweet.source                  = t.source
        tweet.text                    = t.text
        tweet.truncated               = t.truncated
        tweet.save!
      end
    end

    private

    def twitter_client
Twitter::Streaming::Client.new do |config|
      config.consumer_key       = ENV.fetch 'CONSUMER_KEY'
      config.consumer_secret    = ENV.fetch 'CONSUMER_SECRET'
      config.oauth_token        = ENV.fetch 'OAUTH_TOKEN'
      config.oauth_token_secret = ENV.fetch 'OAUTH_TOKEN_SECRET'
    end

    end
  end
end
