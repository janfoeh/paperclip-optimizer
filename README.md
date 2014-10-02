# PaperclipOptimizer

[![Gem Version](https://badge.fury.io/rb/paperclip-optimizer.png)](http://badge.fury.io/rb/paperclip-optimizer)
[![Build Status](https://travis-ci.org/janfoeh/paperclip-optimizer.png)](https://travis-ci.org/janfoeh/paperclip-optimizer)
[![Dependency Status](https://gemnasium.com/janfoeh/paperclip-optimizer.png)](https://gemnasium.com/janfoeh/paperclip-optimizer)

PaperclipOptimizer is a [Paperclip](https://github.com/thoughtbot/paperclip) processor for 
optimizing and minifying uploaded images.

It is just a thin wrapper around [ImageOptim](https://github.com/toy/image_optim), 
which supports many external optimization libraries like

* [advpng](http://advancemame.sourceforge.net/doc-advpng.html) from 
  [AdvanceCOMP](http://advancemame.sourceforge.net/comp-readme.html)
* [gifsicle](http://www.lcdf.org/gifsicle/)
* [jpegoptim](http://www.kokkonen.net/tjko/projects.html)
* jpegtran from [Independent JPEG Group's JPEG library](http://www.ijg.org/)
* [optipng](http://optipng.sourceforge.net/)
* [pngcrush](http://pmt.sourceforge.net/pngcrush/)
* [pngout](http://www.advsys.net/ken/util/pngout.htm)

### What's new

**2014-05-02 1.0.3 released**

* updated tests, compatibility with Paperclip 4 - thanks [Sija](https://github.com/Sija)

**2014-04-02 1.0.2 released**

* relax Paperclip dependency, allow 3.4.x again since it works fine

Read the [CHANGELOG](CHANGELOG.md) for previous changes.

### Dependencies

PaperclipOptimizer is currently compatible with Paperclip 3.4.0 to 4.1.x.

## Installation

Add this line to your application's Gemfile after the Paperclip gem:

    gem 'paperclip-optimizer'

And then execute:

    $ bundle

See [ImageOptims README](https://github.com/toy/image_optim#binaries-location) 
on how to install the various optimization libraries.

### Deployment on Heroku

If you deploy to Heroku, take a look at the [image_optim_bin](https://github.com/mooktakim/image_optim_bin) gem. It supplies the necessary 
optimization binaries, compiled and ready for Herokus environment.

    gem "image_optim_bin", group: :production
    gem "paperclip-optimizer"

## Usage

Just add ```:paperclip_optimizer``` to Paperclips ```:processors``` - setting:

```ruby
class User < ActiveRecord::Base
  attr_accessible :avatar
  has_attached_file :avatar, 
                    :styles => { :thumb => "100x100>" },
                    :default_url => "/images/:style/missing.png",
                    :processors => [:thumbnail, :paperclip_optimizer]
end
```

Remember to include the ```:thumbnail``` processor as well if you want to retain 
Paperclips geometry functionality.

### Settings

By default, PaperclipOptimizer only enables _jpegtran_ and _optipng_. You can 
pass configuration options to ImageOptim through the ```:styles``` hash:

```ruby
class User < ActiveRecord::Base
  attr_accessible :avatar
  has_attached_file :avatar, 
                    :styles => {
                      :thumb => {
                        :geometry => "100x100>",
                        :paperclip_optimizer => {
                          :pngout => {
                            :strategy => 1
                          }
                        }
                      }
                    },
                    :default_url => "/images/:style/missing.png",
                    :processors => [:thumbnail, :paperclip_optimizer]
end
```

See [ImageOptims options](https://github.com/toy/image_optim#options) for 
all available options.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

