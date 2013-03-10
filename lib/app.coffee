coffee      = require "coffee-script"
express     = require "express"
stylus      = require "stylus"
nib         = require "nib"
https       = require "https"

app = express()
app.disable "x-powered-by"
app.use express.cookieParser()
app.use express.bodyParser()
app.use express.static("public")
app.use app.router

module.exports = app