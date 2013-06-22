# Description
#   A hubot script to post an eye cleansing image
#
# Dependencies:
#   "hubot-eyebleach": "0.0.1"
#
# Configuration:
#   HUBOT_EYEBLEACH_NSFW=true # Pulls from r/gentlemanboners
#   HUBOT_EYEBLEACH_RANGE=week # Defaults to week
#
# Commands:
#   hubot eyebleach me - post random eye cleansing image
#
# Notes:
#   heh heh
#
# Author:
#   jamesdphillips

request = require "request"
_ = require "underscore"

TrustedDomains = [
  "i.imgur.com",
  "imgur.com",
  "i.minus.com",
  "i.pgu.me"
]

module.exports = (robot) ->
  robot.respond /eye( )?(bleach|cleanse) me$/i, (msg) ->
    eyeBleachMe (url) ->
      msg.send url

eyeBleachMe = (cb) ->
  subreddit = if _.isEmpty(process.env.HUBOT_EYEBLEACH_NSFW) then "cute" else "gentlemanboners"
  range = process.env.HUBOT_EYEBLEACH_RANGE
  range = "month" if _.isEmpty(range)
  url = "http://www.reddit.com/r/#{subreddit}/top.json?t=#{range}&limit=50"
  request {url: url, json: true}, (err, res, body) ->
    if !err and body and body.data and body.data.children
      entries = validEntries(body.data.children)
      entry = pickRandom(entries)
      image = negotiateUrl(entry)
      cb(image) if entry

negotiateUrl = (entry) ->
  if entry.data.domain == "imgur.com"
    "#{entry.data.url}.jpg"
  else
    entry.data.url

pickRandom = (entries) ->
  unless _.isEmpty entries
    index = _.random 0, (entries.length - 1)
    entries[index]

validEntries = (data) ->
  _.filter data, (entry) ->
    entry.data.domain in TrustedDomains
