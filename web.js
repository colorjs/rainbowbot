require('coffee-script')
require('./web/api.coffee').listen(process.env.PORT || 5000)