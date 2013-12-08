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

  let(:tweet) { Tweet.new(text: text)  }

  describe '#trainable_sentiment' do
    subject(:trainable_sentiment) { tweet.trainable_sentiment }

    context 'tweet with sad emoticon' do
      let(:text) { "hangover :(" }

      it('is a sad tweet') do
        expect(trainable_sentiment).to eq([:sad])
      end
    end

    context 'tweet with happy emoticon' do
      let(:text) {
        "lets celebrate our bb birthday together kekekek — haha! yes we"\
        "will!!! :) http://t.co/jpItlVXKH0"
      }

      it('is a happy tweet') do
        expect(trainable_sentiment).to eq([:happy])
      end
    end

    context 'tweet with happy and sad emoticon' do
      let(:text) { ":) hangover :(" }

      it('is a sad tweet') do
        expect(trainable_sentiment).to eq([:happy, :sad])
      end
    end

  end

  describe '#remove_users' do
    subject(:remove_users) { tweet.remove_users }

    let(:text) { '@stankbieber Follow back? please:) @stankbieber' }
    let(:text_without_users) { 'Follow back? please:)' }

    it('removes @stankbieber')do
      expect(remove_users).to eq(text_without_users)
    end

    it('does not change tweet.text') do
      remove_users
      expect(tweet.text).to eq(text)
    end

    describe '!' do
      subject(:remove_users) { tweet.remove_users! }

      it('removes @stankbieber')do
        expect(remove_users).to eq(text_without_users)
      end

      it('change tweet.text') do
        remove_users
        expect(tweet.text).to eq(text_without_users)
      end
    end
  end

  describe '#remove_rt' do
    subject(:remove_rt) { tweet.remove_rt }

    context 'text with rt on middle of word' do
      let(:text) { 'RT Follow back? invert:)' }
      let(:text_without_rt) { 'Follow back? invert:)' }

      it('removes RT but dont remove invert')do
        expect(remove_rt).to eq(text_without_rt)
      end
    end

    context 'text with RT' do
      let(:text) { 'RT Follow back? please:)' }
      let(:text_without_rt) { 'Follow back? please:)' }

      it('removes RT')do
        expect(remove_rt).to eq(text_without_rt)
      end

      it('does not change tweet.text') do
        remove_rt
        expect(tweet.text).to eq(text)
      end

      describe '!' do
        subject(:remove_rt) { tweet.remove_rt! }

        it('removes RT')do
          expect(remove_rt).to eq(text_without_rt)
        end

        it('change tweet.text') do
          remove_rt
          expect(tweet.text).to eq(text_without_rt)
        end
      end
    end
  end

  describe '#remove_emoticons' do
    subject(:remove_emoticons) { tweet.remove_emoticons }

    let(:text) { 'Follow back? please:)' }
    let(:text_without_emoticons) { 'Follow back? please' }

    it('removes :)')do
      expect(remove_emoticons).to eq(text_without_emoticons)
    end

    it('does not change tweet.text') do
      remove_emoticons
      expect(tweet.text).to eq(text)
    end

    describe '!' do
      subject(:remove_emoticons) { tweet.remove_emoticons! }

      it('removes :)')do
        expect(remove_emoticons).to eq(text_without_emoticons)
      end

      it('change tweet.text') do
        remove_emoticons
        expect(tweet.text).to eq(text_without_emoticons)
      end
    end
  end


  describe '#remove_accents' do
    subject(:remove_accents) { tweet.remove_accents }

    let(:text) {
      "Rosa Luxemburgo, em polonês Róża Luksemburg (Zamość, 5 de março de "\
      "1871 — Berlim, 15 de janeiro de 1919), foi uma filósofa e economista "\
      "marxista polonesa , alemã. Tornou-se mundialmente conhecida pela "\
      "militância revolucionária ligada à Social-Democracia do Reino da "\
      "Polônia e Lituânia (SDKP), ao Partido Social-Democrata da Alemanha "\
      "(SPD) e ao Partido Social-Democrata Independente da Alemanha (USPD). "\
      "Participou da fundação do grupo de tendência marxista do SPD, que "\
      "viria a se tornar mais tarde o Partido Comunista da Alemanha (KPD)."
    }

    let(:text_without_accents) {
      "Rosa Luxemburgo, em polones Roza Luksemburg (Zamosc, 5 de marco de "\
      "1871 ? Berlim, 15 de janeiro de 1919), foi uma filosofa e economista "\
      "marxista polonesa , alema. Tornou-se mundialmente conhecida pela "\
      "militancia revolucionaria ligada a Social-Democracia do Reino da "\
      "Polonia e Lituania (SDKP), ao Partido Social-Democrata da Alemanha "\
      "(SPD) e ao Partido Social-Democrata Independente da Alemanha (USPD). "\
      "Participou da fundacao do grupo de tendencia marxista do SPD, que "\
      "viria a se tornar mais tarde o Partido Comunista da Alemanha (KPD)."
    }

    it('remove accents') {
      expect(remove_accents).to eq(text_without_accents)
    }

    it('does not change twitter.text') {
      remove_accents
      expect(tweet.text).to eq(text)
    }

    describe '!' do
      subject(:remove_accents) { tweet.remove_accents! }

      it('remove accents') {
        expect(remove_accents).to eq(text_without_accents)
      }

      it('change twitter.text') {
        remove_accents
        expect(tweet.text).to eq(text_without_accents)
      }
    end
  end

  describe '#remove_not_alphanumeric' do
    subject(:remove_not_alphanumeric) { tweet.remove_not_alphanumeric }

    let(:text) {
      "Rosa Luxemburgo, em polonês Róża Luksemburg (Zamość, 5 de março de "\
      "1871 — Berlim, 15 de janeiro de 1919), foi uma filósofa e economista "\
      "marxista polonesa , alemã. Tornou-se mundialmente conhecida pela "\
      "militância revolucionária ligada à Social-Democracia do Reino da "\
      "Polônia e Lituânia (SDKP), ao Partido Social-Democrata da Alemanha "\
      "(SPD) e ao Partido Social-Democrata Independente da Alemanha (USPD). "\
      "Participou da fundação do grupo de tendência marxista do SPD, que "\
      "viria a se tornar mais tarde o Partido Comunista da Alemanha (KPD)."
    }

    let(:text_without_not_alphanumeric) {
      "Rosa Luxemburgo em polonês Ró a Luksemburg Zamo 5 de março de 1871 "\
      "Berlim 15 de janeiro de 1919 foi uma filósofa e economista marxista "\
      "polonesa alemã Tornou se mundialmente conhecida pela militância "\
      "revolucionária ligada à Social Democracia do Reino da Polônia e "\
      "Lituânia SDKP ao Partido Social Democrata da Alemanha SPD e ao "\
      "Partido Social Democrata Independente da Alemanha USPD Participou da "\
      "fundação do grupo de tendência marxista do SPD que viria a se tornar "\
      "mais tarde o Partido Comunista da Alemanha KPD"
    }

    it('remove not alphanumeric characters') {
      expect(remove_not_alphanumeric).to eq(text_without_not_alphanumeric)
    }

    it('does not change twitter.text') {
      remove_not_alphanumeric
      expect(tweet.text).to eq(text)
    }

    describe '!' do
      subject(:remove_not_alphanumeric) { tweet.remove_not_alphanumeric! }

      it('remove accents') {
        expect(remove_not_alphanumeric).to eq(text_without_not_alphanumeric)
      }

      it('change twitter.text') {
        remove_not_alphanumeric
        expect(tweet.text).to eq(text_without_not_alphanumeric)
      }
    end
  end

  describe '#normalize' do
    let(:text) {
      "@rosaluxemburgo, em polonês Róża Luksemburg (Zamość, 5 de março de "\
      "1871 — Berlim, 15 de janeiro de 1919), foi uma filósofa e economista "\
      "marxista polonesa , alemã. Tornou-se mundialmente conhecida pela "\
      "militância revolucionária ligada à Social-Democracia do Reino da "\
      "Polônia e Lituânia (SDKP), ao Partido Social-Democrata da Alemanha "\
      "(SPD) e ao Partido Social-Democrata Independente da Alemanha (USPD). "\
      "Participou da fundação do grupo de tendência marxista do SPD, que "\
      "viria a se tornar mais tarde o Partido Comunista da Alemanha (KPD) :)."
    }

    let(:text_normalized) {
      "em polones roza luksemburg zamosc 5 de marco de 1871 berlim 15 de "\
      "janeiro de 1919 foi uma filosofa e economista marxista polonesa alema "\
      "tornou se mundialmente conhecida pela militancia revolucionaria "\
      "ligada a social democracia do reino da polonia e lituania sdkp ao "\
      "partido social democrata da alemanha spd e ao partido social "\
      "democrata independente da alemanha uspd participou da fundacao do "\
      "grupo de tendencia marxista do spd que viria a se tornar mais tarde o "\
      "partido comunista da alemanha kpd"
    }

    describe '!' do
      subject(:normalize) { tweet.normalize! }

      it('normalize text') {
        expect(normalize).to eq(text_normalized)
      }

      it('change twitter.text') {
        normalize
        expect(tweet.text).to eq(text_normalized)
      }
    end
  end
end
