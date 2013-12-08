require 'spec_helper'

describe TweetNormalizer do
  subject(:normalizer) { TweetNormalizer.new }

  subject(:tweet) { Tweet.new text: text }

  describe '#remove_users' do
    subject(:remove_users) { normalizer.remove_users tweet }

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
      subject(:remove_users) { normalizer.remove_users! tweet }

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
    subject(:remove_rt) { normalizer.remove_rt tweet }

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
        subject(:remove_rt) { normalizer.remove_rt! tweet }

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
    subject(:remove_emoticons) { normalizer.remove_emoticons tweet }

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
      subject(:remove_emoticons) { normalizer.remove_emoticons! tweet }

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
    subject(:remove_accents) { normalizer.remove_accents tweet }

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
      subject(:remove_accents) { normalizer.remove_accents! tweet }

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
    subject(:remove_not_alphanumeric) { normalizer.remove_not_alphanumeric tweet }

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
      subject(:remove_not_alphanumeric) {
        normalizer.remove_not_alphanumeric! tweet
      }

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
      subject(:normalize) { normalizer.normalize! tweet }

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
