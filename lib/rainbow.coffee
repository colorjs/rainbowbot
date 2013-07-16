quantize = require "./quantize.js"
http = require "http"
fs = require "fs"
Canvas = require "canvas"
chroma = require "chroma-js"

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

      out =
        hex: []
        rgb: []
        hsv: []
        hsl: []
        lab: []
        lch: []
      for rgb in raw_palette
        color = chroma.color(rgb)
        out.hex.push color.hex()  # "#FF0000"
        out.rgb.push color.rgb()  # [255, 0, 0]
        out.hsv.push color.hsv()  # [0, 1, 1]
        out.hsl.push color.hsl()  # [0, 1, 0.5]
        out.lab.push color.lab()  # [53.2407, 80.0924, 67.2031]
        out.lch.push color.lch()  # [53.2407, 104.5517, 39.9990]

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