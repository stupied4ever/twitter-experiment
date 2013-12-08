module Streams
  class Forest
    def initialize twitter_client = twitter_client
      @twitter_client = twitter_client
    end

    def run
      @twitter_client.sample(language: 'en') do |t|
        tweet = ::Tweet.from t
        tweet.trainable = tweet.is_trainable?
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
