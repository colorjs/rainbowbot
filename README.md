Rainbowbot
==========

A webservice for extracting colors from images.

![Chicken Colors](https://s3.amazonaws.com/f.cl.ly/items/431b1d283D1U2L441z1w/chicken-colors.png)

## API

Get a JSON palette:

[/?url=http://f.cl.ly/items/1n1c1P0I2U3O2r3n0H0D/chicken.jpg](http://rainbowbot.herokuapp.com/?url=http://f.cl.ly/items/1n1c1P0I2U3O2r3n0H0D/chicken.jpg)

Or view the palette in your browser:

[/show?url=http://f.cl.ly/items/1n1c1P0I2U3O2r3n0H0D/chicken.jpg](http://rainbowbot.herokuapp.com/show?url=http://f.cl.ly/items/1n1c1P0I2U3O2r3n0H0D/chicken.jpg)

## Deployment to Heroku

```
npm install app.json --global
app.json deploy zeke/rainbowbot
```

## Development (OS X)

If you're on Mountain Lion, you'll need to install [XQuartz](https://xquartz.macosforge.org).

```sh
brew install cairo
brew install jpg
```
