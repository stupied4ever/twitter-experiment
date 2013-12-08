Twitter Experiment
==================

What about classify sentiments on [twitter][twitter] sample data?

__ATTENTION__
-------------

As the name says, it's __experimental__. Please, don't be a fool, ths is not
to be used on production environment.


Configuration
-------------

Twitter Experiment need to authenticate on [Twitter developers][dev-twitter],
because of that you need to export some variables. To handle that we use
[dotenv][dotenv]. So all you need to do is:

 - Copy env.sample to .env.

 ```
 cp config/env.sample .env
 ```
 - Copy mongoid.sample to mongoid.yml

 ```
 cp config/mongoid.sample mongoid.yml
 ```
 - Edit .env with your own keys


Copus Generation
----------------

[Twitter Api Terms][twitter-api-terms] does not allow to share or resyndicate
Twitter content, cause of that I will not do it.

However, its possible to generate a script to create a corpus, and i did that.
The corpus generator uses [Twitter][twitter] stream. This script is composed of
two parts.

 - Use Twitter Streaming API to download tweets.
 ```
 foreman run forest
 ```

 That will consume [Twitter Sample Stream][twitter-streaming-api] and save on
 a [MongoDB][mongodb] database. It will never finish, you need to decide how
 big you wnat your corpus, and when decided is enough, simple stop it.
 Trainable tweets will be flagged.

 To detect __trainable_tweets__ I simple look to emoticons. If tweet has a
 happy or a sad emoticon, it's trainable tweet. This idea was not mine, I found
 it on ['Twitter as a Corpus for Sentiment Analysis and Opinion Mining'][alexander-pak-patrick-paroubek] (A Pak, P Paroubek - LREC, 2010).

 - After that you neet to __train__ the classifier.

 ```
 foreman run forest_train
 ```
 that will generate a folder ```bayes_data``` with yout train.

 ----


[twitter]: http://twitter.com
[dev-twitter]: https://dev.twitter.com/
[dotenv]: https://github.com/bkeepers/dotenv
[naive-bayes-classifier]: http://en.wikipedia.org/wiki/Naive_Bayes_classifier
[twitter-api-terms]: https://dev.twitter.com/terms/api-terms
[twitter-streaming-api]: https://dev.twitter.com/docs/streaming-apis
[mongodb]: http://www.mongodb.org/
[alexander-pak-patrick-paroubek]: http://www.lrec-conf.org/proceedings/lrec2010/summaries/385.html
