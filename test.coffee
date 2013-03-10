Rainbow = require './lib/rainbow'

Rainbow.paletteSize = 10

url = "http://images.wikia.com/random-ness/images/e/e9/Full_screen_nyan.png"


Rainbow.get url, (palette) ->
  console.log palette
  # for hex in palette.hex
  #   console.log "<div style='width:100px;height:100px;background-color:#{hex}'>test</div>"
