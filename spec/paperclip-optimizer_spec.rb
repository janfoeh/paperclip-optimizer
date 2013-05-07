require "spec_helper"
require "fileutils"

describe Paperclip::PaperclipOptimizer do
  before(:each) do
    tmp_dir = File.join(File.dirname(__FILE__), 'tmp')
    
    Dir.entries(tmp_dir).each do |f|
      next unless f.end_with?(".jpg", ".png")

      FileUtils.remove_entry_secure( File.join(tmp_dir, f) )
    end
  end

  it "creates smaller JPEGs" do
    jpg = get_fixture(:jpg)
    unoptimized_upload = UploadWithoutOptimizer.new(:image => jpg)
    jpg.close
    unoptimized_upload.save

    jpg = get_fixture(:jpg)
    optimized_upload = UploadWithOptimizer.new(:image => jpg)
    jpg.close
    optimized_upload.save

    unoptimized_file_size  = File.size(unoptimized_upload.image.path(:medium))
    optimized_file_size    = File.size(optimized_upload.image.path(:medium))

    expect(optimized_file_size).to be < unoptimized_file_size
  end

  it "creates smaller PNGs" do
    png = get_fixture(:png)
    unoptimized_upload = UploadWithoutOptimizer.new(:image => png)
    unoptimized_upload.save
    png.close

    png = get_fixture(:png)
    optimized_upload = UploadWithOptimizer.new(:image => png)
    optimized_upload.save
    png.close

    unoptimized_file_size  = File.size(unoptimized_upload.image.path(:medium))
    optimized_file_size    = File.size(optimized_upload.image.path(:medium))

    expect(optimized_file_size).to be < unoptimized_file_size
  end

  it "creates an error when an invalid image is saved" do
    jpg = get_fixture(:jpg, "invalid")
    upload = UploadOptimizeOnly.new(:image => jpg)
    upload.save
    jpg.close
    
    expect(upload.errors).not_to be_empty
    expect(upload.errors.full_messages.first).to eq("Image compressing invalid.jpg failed: ImageOptim did not return a compressed image")
  end
end