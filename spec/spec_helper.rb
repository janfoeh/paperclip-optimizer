require 'paperclip'
require 'paperclip/railtie'
# require 'filemagic'
require 'paperclip-optimizer'

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
  self.table_name = "uploads"

  has_attached_file :image,
      :storage    => :filesystem,
      :path       => "./spec/tmp/:id.:extension",
      :url        => "/spec/tmp/:id.:extension",
      :styles     => lambda { |attachment| attachment.instance.style_settings },
      :processors => lambda { |instance| instance.processor_settings }

  do_not_validate_attachment_file_type :image

  def style_settings
    { 
      medium: { geometry: "500x500>" }
    }
  end

  def processor_settings
    [:thumbnail]
  end
end

def get_fixture(file_type = :jpg, valid = "valid")
  file_name     = "#{valid}.#{file_type.to_s}"
  fixtures_dir  = File.join(File.dirname(__FILE__), "../fixtures")
  fixture_path  = File.join(fixtures_dir, file_name)

  File.open(fixture_path)
end
