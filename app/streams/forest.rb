module Streams
  class Forest
    def initialize twitter_client = twitter_client
      @twitter_client = twitter_client
    end

    def run train_corpus = false
      sentiment_finder = SentimentFinder.new

      @twitter_client.sample(language: 'en') do |t|
        tweet = ::Tweet.from t

        if train_corpus
          next unless sentiment_finder.has_sentiment? tweet.text
        end

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
