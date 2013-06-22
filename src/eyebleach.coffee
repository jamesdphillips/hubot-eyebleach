# Description
#   A hubot script to post an eye cleansing image
#
# Dependencies:
#   "hubot-eyebleach": "0.0.1"
#
# Configuration:
#   HUBOT_EYECLEANSE_NSFW=true # Pulls from r/gentlemanboners
#
# Commands:
#   hubot eyecleanse me - post random eye cleansing image
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
  "i.minus.com",
  "i.pgu.me"
]

module.exports = (robot) ->
  robot.respond /eyecleanse me$/i, (msg) ->
    eyeBleachMe (url) ->
      msg.send url


eyeBleachMe = (cb) ->
  subreddit = if process.env.HUBOT_EYECLEANSE_NSFW? then "gentlemanboners" else "cute"
  url = "http://www.reddit.com/r/#{subreddit}/top.json?t=week&limit=75"
  request {url: url, json: true}, (err, res, body) ->
    if !err and body and body.data and body.data.children
      entries = validEntries(body.data.children)
      entry = pickRandom(entries)
      cb(entry.data.url) if entry

pickRandom = (entries) ->
  unless _.isEmpty entries
    index = _.random 0, (entries.length - 1)
    entries[index]

validEntries = (data) ->
  _.filter data, (entry) ->
    entry.data.domain in TrustedDomains
