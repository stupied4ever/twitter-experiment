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
 - Edit .env with your own keys



[twitter]: http://twitter.com
[dev-twitter]: https://dev.twitter.com/
[dotenv]: https://github.com/bkeepers/dotenv
