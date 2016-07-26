#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

# Enabling **debug_mode** prevents the bot from actually sending
# tweets. Keep this active while you are developing your bot. Once you
# are ready to send out tweets, you can remove this line.
# debug_mode

# Chatterbot will keep track of the most recent tweets your bot has
# handled so you don't need to worry about that yourself. While
# testing, you can use the **no_update** directive to prevent
# chatterbot from updating those values. This directive can also be
# handy if you are doing something advanced where you want to track
# which tweet you saw last on your own.
# no_update

# remove this to get less output when running your bot
verbose

# ignore 'cut/give ... slack', 'slack off' tweets
exclude "cut", "give", "off"

# filter out users
blocklist "SLACK_TV"

def like(tweet)
  if bot.valid_tweet?(tweet)
    favorite tweet.id
    puts "Favorited: #{tweet.text}"
  end
end

# request limit is 15 requests per 15 minute window
puts "Searching: slack company"
client.search("slack company", result_type: "recent").take(6).each do |tweet|
  like tweet
end

puts "Searching: slack emoji"
client.search("slack emoji", result_type: "recent").take(6).each do |tweet|
  like tweet
end

# this block responds to mentions of your bot
#
#replies do |tweet|
#  # Any time you put the #USER# token in a tweet, Chatterbot will
#  # replace it with the handle of the user you are interacting with
#  reply "Yes #USER#, you are very kind to say that!", tweet
#end

#
# this block handles incoming Direct Messages. if you want to do
# something with DMs, go for it!
# 
# direct_messages do |dm|
#  puts "DM received: #{dm.text}"
#  direct_message "HELLO, I GOT YOUR MESSAGE", dm.sender
# end

#
# Use this block to get tweets that appear on your bot's home timeline
# (ie, if you were visiting twitter.com) -- using this block might
# require a little extra work but can be very handy
#
# home_timeline do |tweet|
#  puts tweet.inspect
# end
