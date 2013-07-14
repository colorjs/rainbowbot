quantize = require "./quantize.js"
http = require "http"
fs = require "fs"
Canvas = require "canvas"
color = require "onecolor"

class Rainbow

  @paletteSize: 8

  @get: (url, callback) ->

    Image = Canvas.Image
    img = new Image
    start = new Date

    img.onerror = (err) ->
      throw err

    img.onload = ->

      # Assemble a Canvas element from the downloaded image
      w = img.width
      h = img.height
      canvas = new Canvas(w, h)
      ctx = canvas.getContext("2d")
      ctx.drawImage(img, 0, 0, w, w)
      pixels = ctx.getImageData(0, 0, w, h).data
      pixelCount = w * h

      # Munge RGB values into quantize-compatible format
      # [[r,g,b], [r,g,b], ...]
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

        # If pixel is mostly opaque
        if a >= 125
          # .. and not white
          unless r > 250 and g > 250 and b > 250
            pixelArray.push [r, g, b]

        i++

      cmap = quantize(pixelArray, Rainbow.paletteSize)
      raw_palette = cmap.palette()

      out = {}
      out.hex = []
      out.rgba = []
      for rgb in raw_palette
        b = rgb.pop()
        g = rgb.pop()
        r = rgb.pop()
        fmt = "rgb(#{r}, #{g}, #{b})"
        out.hex.push color(fmt).hex().toUpperCase()
        out.rgba.push color(fmt).cssa()

      callback(out)

    filename = "/tmp/" + (new Date).getTime() + "_" + url.split("/").pop()

    file = fs.createWriteStream(filename)
    req = http.get url, (res) ->
      res.on("data", (data) ->
        file.write data
      ).on "end", ->
        file.end()
        img.src = filename

module.exports = Rainbow