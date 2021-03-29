
require 'spec_helper'
require 'fileutils'

describe Paperclip::PaperclipOptimizer do

  def stubbed_upload_model(*args)
    stubbed_model = Upload.dup

    # prevent ActiveModel::Validations from blowing up when error messages are
    # accessed on an anonymous class
    allow(stubbed_model).to receive(:model_name) { ActiveModel::Name.new(self, nil, 'temp') }
    stubbed_model.any_instance.stub(*args)

    stubbed_model
  end

  before(:each) do
    tmp_dir = File.join(File.dirname(__FILE__), 'tmp')

    Dir.mkdir(tmp_dir) unless File.directory?(tmp_dir)

    Dir.entries(tmp_dir).each do |f|
      next unless f.end_with?('.jpg', '.png')

      FileUtils.remove_entry_secure( File.join(tmp_dir, f) )
    end
    
    Paperclip::PaperclipOptimizer.default_options = PaperclipOptimizer::DEFAULT_OPTIONS
  end

  it 'creates smaller JPEGs with jpegtran' do
    jpg = get_fixture(:jpg)
    unoptimized_upload = Upload.new(image: jpg)
    jpg.close
    unoptimized_upload.save

    jpg = get_fixture(:jpg)
    optimized_upload  = stubbed_upload_model(
                          processor_settings: [:thumbnail, :paperclip_optimizer],
                          instance_settings:  { jpegtran: true }
                        ).new(image: jpg)
    jpg.close
    optimized_upload.save

    unoptimized_file_size  = File.size(unoptimized_upload.image.path(:medium))
    optimized_file_size    = File.size(optimized_upload.image.path(:medium))

    expect(optimized_file_size).to be < unoptimized_file_size
  end

  it 'creates smaller PNGs with optipng' do
    png = get_fixture(:png)
    unoptimized_upload = Upload.new(image: png)
    unoptimized_upload.save
    png.close

    png = get_fixture(:png)
    optimized_upload  = stubbed_upload_model(
                          processor_settings: [:thumbnail, :paperclip_optimizer],
                          instance_settings:  { optipng: true }
                        ).new(image: png)
    png.close
    optimized_upload.save

    unoptimized_file_size  = File.size(unoptimized_upload.image.path(:medium))
    optimized_file_size    = File.size(optimized_upload.image.path(:medium))

    expect(optimized_file_size).to be < unoptimized_file_size
  end

  it 'merges global, per-model and per-style options' do
    global_options       = PaperclipOptimizer::DEFAULT_OPTIONS.merge( gifsicle: { interlace: true }, jpegtran: true )
    final_merged_options = PaperclipOptimizer::DEFAULT_OPTIONS.merge( jpegtran: true, optipng: true )
    
    Paperclip::PaperclipOptimizer.default_options = global_options

    expect(ImageOptim).to receive(:new).with(final_merged_options).and_call_original

    jpg = get_fixture(:jpg)

    stubbed_upload_model(
      processor_settings: [:paperclip_optimizer],
      instance_settings:  { gifsicle: false },
      style_settings: {
        medium: {
          paperclip_optimizer: { optipng: true }
        }
      }
    ).new(image: jpg)
  end
end
