# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paperclip-optimizer/version'

Gem::Specification.new do |spec|
  spec.name          = "paperclip-optimizer"
  spec.version       = PaperclipOptimizer::VERSION
  spec.authors       = ["Jan-Christian Föh"]
  spec.email         = ["jan@programmanstalt.de"]
  spec.description   = %q{paperclip-optimizer is a processor for Paperclip that allows you to optimize and minify uploaded JPEG and PNG files.}
  spec.summary       = %q{Minify Paperclip JPEG and PNG attachments}
  spec.homepage      = "https://github.com/janfoeh/paperclip-optimizer"
  spec.license       = "MIT"

  spec.add_runtime_dependency "paperclip", ">= 3.4"
  spec.add_runtime_dependency "image_optim", "~> 0.9"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency 'rspec', "~> 2.13"
  spec.add_development_dependency 'rails', ">= 3.2.13", "< 4.1.0"
  spec.add_development_dependency 'sqlite3', "~> 1.3.7"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
