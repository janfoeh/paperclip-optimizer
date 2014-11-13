# CHANGELOG

## 2.0.0.beta.2

* re-enable compatibility with Paperclip 3.4.2

## 2.0.0.beta

* **all available optimization libraries are disabled by default**

  Previous versions enabled jpegtran and optipng by default. You will have to 
  re-enable them manually if you wish to retain that behaviour

* configure PaperclipOptimizer globally, per-attachment and per-style

  Thanks to [danschultzer](https://github.com/danschultzer), [braindeaf](https://github.com/braindeaf) and 
  [tirdadc](https://github.com/tirdadc) for pull requests, input and reports

## 1.0.3

* updated tests, compatibility with Paperclip 4 - thanks [Sija](https://github.com/Sija)

## 1.0.2

* relax Paperclip dependency, allow 3.4.x again since it works fine

## 1.0.1

* do not produce verbose log output by default - thanks [Sunny Ripert](https://github.com/sunny)
* declare the dependency on Paperclip only once - thanks [Sunny Ripert](https://github.com/sunny)

## 1.0.0

* we're going to 1.0.0 after six months in production
* use image_optim 0.9 and upwards
* use Paperclip 3.5.2 and upwards
* document image_optim_bin for use on Heroku
* add a CHANGELOG

## 0.2.0

* initial release