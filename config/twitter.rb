@@twitter_client = Twitter::Streaming::Client.new do |config|
  config.consumer_key       = ENV.fetch 'CONSUMER_KEY'
  config.consumer_secret    = ENV.fetch 'CONSUMER_SECRET'
  config.oauth_token        = ENV.fetch 'OAUTH_TOKEN'
  config.oauth_token_secret = ENV.fetch 'OAUTH_TOKEN_SECRET'
end

