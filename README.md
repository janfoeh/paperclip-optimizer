# PaperclipOptimizer

[![Gem Version](https://badge.fury.io/rb/paperclip-optimizer.png)](http://badge.fury.io/rb/paperclip-optimizer)
[![Build Status](https://travis-ci.org/janfoeh/paperclip-optimizer.png)](https://travis-ci.org/janfoeh/paperclip-optimizer)
[![Dependency Status](https://gemnasium.com/janfoeh/paperclip-optimizer.png)](https://gemnasium.com/janfoeh/paperclip-optimizer)

PaperclipOptimizer is a [Paperclip](https://github.com/thoughtbot/paperclip) processor for
optimizing and minifying uploaded images.

It is just a thin wrapper around [ImageOptim](https://github.com/toy/image_optim),
which supports many external optimization libraries such as [advpng](http://advancemame.sourceforge.net/doc-advpng.html), [gifsicle](http://www.lcdf.org/gifsicle/),
[jhead](http://www.sentex.net/~mwandel/jhead/), [jpegoptim](http://www.kokkonen.net/tjko/projects.html), [jpeg-recompress](https://github.com/danielgtaylor/jpeg-archive#jpeg-recompress),
[jpegtran](http://www.ijg.org/), [optipng](http://optipng.sourceforge.net/), [pngcrush](http://pmt.sourceforge.net/pngcrush/), [pngout](http://www.advsys.net/ken/util/pngout.htm),
[pngquant](http://pngquant.org/) and [svgo](https://github.com/svg/svgo).

### What's new

**2015-01-16 2.0.0**

* better configuration: set options [globally, per attachment and per style](#settings)

  Thanks to [danschultzer](https://github.com/danschultzer), [braindeaf](https://github.com/braindeaf) and
  [tirdadc](https://github.com/tirdadc) for pull requests, input and reports
* all available optimization libraries are disabled by default

  Previous versions enabled jpegtran and optipng by default. You will have to
  re-enable them manually if you wish to retain that behaviour
* optimizers which are enabled but missing or broken are ignored by default

Read the [CHANGELOG](CHANGELOG.md) for previous changes.

### Dependencies

PaperclipOptimizer is currently compatible with Paperclip 3.4.2 up to 4.2.x.

## Installation

Add this line to your application's Gemfile after the Paperclip gem:

    gem 'paperclip-optimizer'

And then execute:

    $ bundle

If you wish to set global configuration settings, run

    $ rails generate paperclip_optimizer:install

to generate an initializer in config/initializers.

### CAUTION

**image_optim automatically inserts itself into the asset pipeline and tries to compress your `/app/assets/images` as well.
Since it enables all libraries it supports by default, you might suddenly run into errors if you do not have all
of them installed.**

Please note: settings you made through PaperclipOptimizer only apply to Paperclip attachments, not to image_optims asset compressor.

To disable image_optim in your asset pipeline, add

```ruby
    # config/application.rb
    config.assets.image_optim = false
```

to your config/application.rb.

See [ImageOptims README](https://github.com/toy/image_optim#binaries-location)
on how to install the various optimization libraries.

### Deployment on Heroku

If you deploy to Heroku, take a look at the [image_optim_bin](https://github.com/mooktakim/image_optim_bin) gem. It supplies the necessary
optimization binaries, compiled and ready for Herokus environment. Make sure to include it **before** paperclip-optimizer.

    gem "image_optim_bin", group: :production
    gem "paperclip-optimizer"

## Usage

Just add `:paperclip_optimizer` to Paperclips' `:processors` - setting:

```ruby
class User < ActiveRecord::Base
  attr_accessible :avatar
  has_attached_file :avatar,
                    styles: { thumb: "100x100>" },
                    processors: [:thumbnail, :paperclip_optimizer]
end
```

Remember to include the `:thumbnail` processor as well if you want to retain
Paperclips geometry functionality.

### Settings

You can pass configuration options to ImageOptim in three locations: globally, per attachment and per style.
Settings are merged, so more specific settings replace less specific ones.

**Global settings**

Global settings apply everywhere. You can override them with per-attachment and per-style settings.

Run `rails generate paperclip_optimizer:install` to create an initializer for global settings.

```ruby
# config/initializers/paperclip_optimizer.rb
Paperclip::PaperclipOptimizer.default_options = {
  skip_missing_workers: false
}
```

**Per-attachment settings**

Per-attachment settings apply to all styles of a particular attachment. Override them with per-style settings.

```ruby
class User < ActiveRecord::Base
  attr_accessible :avatar
  has_attached_file :avatar,
                    processors: [:thumbnail, :paperclip_optimizer],
                    paperclip_optimizer: {
                      pngout: { strategy: 1 }
                    },
                    styles: {
                      thumb:  { geometry: "100x100>" },
                      medium: { geometry: "200x200>" },
                      large:  { geometry: "300x300>" }
                    }
end
```

Just like Paperclips' `:styles` option, you can pass a lambda to `:paperclip_optimizer` to configure it at runtime:

```ruby
class User < ActiveRecord::Base
  attr_accessible :avatar
  has_attached_file :avatar,
                    processors: [:thumbnail, :paperclip_optimizer],
                    paperclip_optimizer: ->(attachment) { attachment.instance.my_model_instance_method },
                    styles: {
                      thumb:  { geometry: "100x100>" },
                      medium: { geometry: "200x200>" },
                      large:  { geometry: "300x300>" }
                    }
end
```

**Per-style settings**

```ruby
class User < ActiveRecord::Base
  attr_accessible :avatar
  has_attached_file :avatar,
                    processors: [:thumbnail, :paperclip_optimizer],
                    paperclip_optimizer: {
                      pngout: { strategy: 1 }
                    },
                    styles: {
                      thumb:  { geometry: "100x100>" },
                      medium: { geometry: "200x200>" },
                      large:  {
                        geometry: "300x300>",
                        paperclip_optimizer: {
                          pngout: { strategy: 4 }
                        }
                      }
                    }
end
```

See [ImageOptims options](https://github.com/toy/image_optim#options) or the initializer for
all available options.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
