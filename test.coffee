Rainbow = require './lib/rainbow'

Rainbow.paletteSize = 10

url = "http://static.tumblr.com/g4jzgza/6x5lomj7s/nyan_250.png"

Rainbow.get url, (palette) ->
  console.log palette
  for hex in palette.hex
    console.log "<div style='width:100px;height:100px;background-color:#{hex}'>test</div>"
    
  