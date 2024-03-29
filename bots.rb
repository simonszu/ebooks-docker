require 'twitter_ebooks'

# This is an example bot definition with event handlers commented out
# You can define and instantiate as many bots as you like


class MyBot < Ebooks::Bot
  # Configuration here applies to all MyBots
  def configure
    # Consumer details come from registering an app at https://dev.twitter.com/
    # Once you have consumer details, use "ebooks auth" for new access tokens
    self.consumer_key = "${CONSUMER_KEY}" # Your app consumer key
    self.consumer_secret = "${CONSUMER_SECRET}" # Your app consumer secret

    # Users to block instead of interacting with
    self.blacklist = ['tnietzschequote']

    # Range in seconds to randomize delay when bot.delay is called
    self.delay_range = 1..6
    @model = Ebooks::Model.load("model/${USER}.model")
  end

  def on_startup
    scheduler.every '30m' do
      # Tweet something every 24 hours
      # See https://github.com/jmettraux/rufus-scheduler
      # tweet("hi")
      # pictweet("hi", "cuteselfie.jpg")
      tweet(@model.make_statement(280))
    end
  end

  def on_message(dm)
    # Reply to a DM
    # reply(dm, "secret secrets")
  end

  def on_follow(user)
    # Follow a user back
    follow(user.screen_name)
  end

  def on_mention(tweet)
    # Reply to a mention
    reply(tweet, @model.make_statement(280))
  end

  def on_timeline(tweet)
    # Reply to a tweet in the bot's timeline
    # reply(tweet, "nice tweet")
  end

  def on_favorite(user, tweet)
    # Follow user who just favorited bot's tweet
    follow(user.screen_name)
  end
end

# Make a MyBot and attach it to an account
MyBot.new("${BOT_USER}") do |bot|
  bot.access_token = "${ACCESS_TOKEN}" # Token connecting the app to this account
  bot.access_token_secret = "${ACCESS_TOKEN_SECRET}" # Secret connecting the app to this account
end
