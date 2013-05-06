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

class UploadBase < ActiveRecord::Base
  self.table_name = "uploads"

  has_attached_file :image,
      :storage    => :filesystem,
      :path       => "./spec/tmp/:id.:extension",
      :url        => "/spec/tmp/:id.:extension",
      :styles     => { medium: "500x500>" },
      :processors => lambda { |instance| instance.processors }
end

class UploadWithoutOptimizer < UploadBase
  def processors
    [:thumbnail]
  end
end

class UploadWithOptimizer < UploadBase
  def processors
    [:thumbnail, :paperclip_optimizer]
  end
end

class UploadOptimizeOnly < UploadBase
  def processors
    [:paperclip_optimizer]
  end
end

def get_fixture(file_type = :jpg, valid = "valid")
  file_name     = "#{valid}.#{file_type.to_s}"
  fixtures_dir  = File.join(File.dirname(__FILE__), "../fixtures")
  fixture_path  = File.join(fixtures_dir, file_name)

  File.open(fixture_path)
end