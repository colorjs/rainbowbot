http = require "http"
fs = require "fs"
request = require "request"
thief = require "thief"
quantize = require "./lib/thief/quantize.js"
Canvas = require("canvas")

Image = Canvas.Image
img = new Image
start = new Date



img.onerror = (err) ->
  throw err

img.onload = ->
  
  width = img.width
  height = img.height
  canvas = new Canvas(width, height)
  ctx = canvas.getContext("2d")
  ctx.drawImage(img, 0, 0, width, height)
  
  pixels = ctx.getImageData(0, 0, width, height).data
  pixelCount = width * height
  # console.log pixels, pixelCount, pixels
    
  # # Store the RGB values in an array format suitable for quantize function
  pixelArray = []
  i = 0
  offset = undefined
  r = undefined
  g = undefined
  b = undefined
  a = undefined
    
  while i < pixelCount
    offset = i * 4
    r = pixels[offset + 0]
    g = pixels[offset + 1]
    b = pixels[offset + 2]
    a = pixels[offset + 3]
        
    # If pixel is mostly opaque and not white
    if a >= 125
      unless r > 250 and g > 250 and b > 250  
        pixelArray.push [r, g, b]
  
    i++
    
  cmap = quantize(pixelArray, 10)
  palette = cmap.palette()
  console.log palette  
  palette

url = "http://2.bp.blogspot.com/_jZHHRfnq9F8/Sw5Kb1D2EhI/AAAAAAAAKkE/fuaDErPNDvU/s1600/Puppy+Training.jpg"
# url = "http://static.tumblr.com/g4jzgza/6x5lomj7s/nyan_250.png"
filename = "" + (new Date).getTime() + "_" + url.split("/").pop()
file = fs.createWriteStream(filename)
request = http.get url, (res) ->
  res.on("data", (data) ->
    file.write data
  ).on "end", ->
    file.end()
    console.log filename + " downloaded"
    img.src = __dirname + "/" + filename
