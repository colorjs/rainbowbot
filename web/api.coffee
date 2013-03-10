cors        = require "cors"
rainbow     = require("../lib/rainbow")
app         = require "../lib/app"

app.get "/mix", cors(), (req, res) ->

  url = req.query.url

  res.jsonp(400, {error: "'url' query param is required"}) unless url

  rainbow.get url, (palette) ->
    # res.jsonp palette
    res.render "mix.jade", {url: url, palette: palette}

module.exports = app