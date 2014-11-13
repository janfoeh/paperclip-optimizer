# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paperclip-optimizer/version'

Gem::Specification.new do |spec|
  spec.name          = 'paperclip-optimizer'
  spec.version       = PaperclipOptimizer::VERSION
  spec.authors       = ['Jan-Christian Föh']
  spec.email         = ['jan@programmanstalt.de']
  spec.description   = 'paperclip-optimizer is a Paperclip processor for optimizing and minifying uploaded images.'
  spec.summary       = 'Minify Paperclip image attachments like JPGs, GIFs or PNGs'
  spec.homepage      = 'https://github.com/janfoeh/paperclip-optimizer'
  spec.license       = 'MIT'

  spec.add_runtime_dependency 'paperclip', '>= 4.2'
  spec.add_runtime_dependency 'image_optim', '~> 0.19.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.1'
  spec.add_development_dependency 'rspec', '~> 2.13'
  spec.add_development_dependency 'rails', '>= 3.2.20', '<= 4.2.0'
  spec.add_development_dependency 'sqlite3', '~> 1.3.7'
  spec.add_development_dependency 'rubocop', '~> 0.26.1'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  
  spec.post_install_message = %q{
Initializer
-----------

run

    rails g paperclip_optimizer:install

to create an initializer for global configuration.

Breaking changes from 1.0.3
---------------------------

Please note that Paperclip 2 now disables all optimization libraries by default. Re-enable jpegtran
and optipng manually if you wish to retain the previous behaviour.

See https://github.com/janfoeh/paperclip-optimizer#settings for more information on the new 
configuration system.

PLEASE NOTE
-----------

PaperclipOptimizer depends on image_optim, which by default inserts itself into the asset pipeline and 
tries to compress your application assets. This might fail if you do not have all supported optimization 
binaries installed. Add

    config.assets.image_optim = false
    
to your config/application.rb to disable this.
}
end
