cors        = require "cors"
express     = require "express"
stylus      = require "stylus"
nib         = require "nib"
https       = require "https"
rainbow     = require "../lib/rainbow"

app = express()
app.disable "x-powered-by"
app.use express.bodyParser()
app.use '/', express.static('public')
app.use app.router

app.get "/mix", cors(), (req, res) ->

  url = req.query.url

  res.jsonp(400, {error: "'url' query param is required"}) unless url

  rainbow.get url, (palette) ->
    res.jsonp palette
    # res.render "mix.jade", {url: url, palette: palette}

module.exports = app