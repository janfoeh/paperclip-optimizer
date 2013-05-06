require 'paperclip'
require 'paperclip/railtie'
# require 'filemagic'
require 'paperclip_optimizer'

require 'rspec'
require 'rspec/autorun'

require "active_record"

# taken from https://github.com/tienle/docsplit-paperclip-processor/blob/master/spec/spec_helper.rb

ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => ":memory:"
)

ActiveRecord::Base.logger = Logger.new(nil)
load(File.join(File.dirname(__FILE__), 'schema.rb'))

Paperclip::Railtie.insert

class Upload < ActiveRecord::Base
  has_attached_file :image,
      :storage    => :filesystem,
      :path       => "./spec/tmp/:id.:extension",
      :url        => "/spec/tmp/:id.:extension",
      :styles     => { medium: "500x500>" },
      :processors => [:paperclip_optimizer]
end