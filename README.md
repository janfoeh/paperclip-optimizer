# PaperclipOptimizer

[![Build Status](https://travis-ci.org/janfoeh/paperclip-optimizer.png)](https://travis-ci.org/janfoeh/paperclip-optimizer)

PaperClipOptimizer is a processor for [Paperclip](https://github.com/thoughtbot/paperclip) that allows 
you to optimize and minify uploaded JPG, PNG or GIF images.

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

## Installation

Add this line to your application's Gemfile after the Paperclip gem:

    gem 'paperclip-optimizer'

And then execute:

    $ bundle

See [ImageOptims README](https://github.com/toy/image_optim#binaries-location) 
on how to install the various optimization libraries.

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

