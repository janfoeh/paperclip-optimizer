require "spec_helper"

describe Paperclip::PaperclipOptimizer do
  # before(:all) do
  #   delete_temp_images
  # end

  it "does not prevent attachments from being saved" do
    jpg = get_fixture(:jpg)

    upload = UploadWithOptimizer.new(:image => jpg)
    jpg.close
    upload.save

    expect(upload.persisted?).to be_true
  end

end