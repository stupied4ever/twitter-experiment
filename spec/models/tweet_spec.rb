require 'spec_helper'

describe Tweet do

  describe '#from' do
    subject(:tweet) { Tweet.from received_tweet }

    let(:received_tweet) {
      Twitter::Tweet.new(
        id:                       id,
        favorite_count:           favorite_count,
        favorited:                favorited,
        in_reply_to_screen_name:  in_reply_to_screen_name,
        in_reply_to_attrs_id:     in_reply_to_attrs_id,
        in_reply_to_status_id:    in_reply_to_status_id,
        in_reply_to_user_id:      in_reply_to_user_id,
        lang:                     lang,
        retweet_count:            retweet_count,
        retweeted:                retweeted,
        source:                   source,
        text:                     text,
        truncated:                truncated,
      )
    }

    let(:id)                      { 'twitter id' }
    let(:favorite_count)          { 1 }
    let(:favorited)               { false }
    let(:in_reply_to_screen_name) { '@stupied4ever' }
    let(:in_reply_to_attrs_id)    { 'some_attr_id' }
    let(:in_reply_to_status_id)   { 'some_status_id'}
    let(:in_reply_to_user_id)     { 'some_user_id' }
    let(:lang)                    { 'pt' }
    let(:retweet_count)           { 100 }
    let(:retweeted)               { true }
    let(:source)                  { 'some source' }
    let(:text)                    { 'Some example text' }
    let(:truncated)               { false }

    it 'has the object favorite_count' do
      expect(tweet.favorite_count).to eq(received_tweet.favorite_count)
    end

    it 'has the object favorited flag' do
      expect(tweet.favorited).to eq(received_tweet.favorited)
    end

    it 'has the object in_reply_to_screen_name' do
      expect(tweet.in_reply_to_screen_name).to eq(
        received_tweet.in_reply_to_screen_name
      )
    end

    it 'has the object in_reply_to_attrs_id' do
      expect(tweet.in_reply_to_attrs_id).to eq(
        received_tweet.in_reply_to_attrs_id
      )
    end

    it 'has the object in_reply_to_status_id' do
      expect(tweet.in_reply_to_status_id).to eq(
        received_tweet.in_reply_to_status_id
      )
    end

    it 'has the object in_reply_to_user_id' do
      expect(tweet.in_reply_to_user_id).to eq(
        received_tweet.in_reply_to_user_id
      )
    end

    it 'has the object lang' do
      expect(tweet.lang).to eq(received_tweet.lang)
    end

    it 'has the object retweet_count' do
      expect(tweet.retweet_count).to eq(received_tweet.retweet_count)
    end

    it 'has the object retweeted flag' do
      expect(tweet.retweeted).to eq(received_tweet.retweeted)
    end

    it 'has the object source' do
      expect(tweet.source).to eq(received_tweet.source)
    end

    it 'has the object text' do
      expect(tweet.text).to eq(received_tweet.text)
    end

    it 'has the object truncated flag' do
      expect(tweet.truncated).to eq(received_tweet.truncated)
    end
  end


end
