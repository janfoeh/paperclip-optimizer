require "paperclip"
require "image_optim"

module Paperclip
  class PaperclipOptimizer < Processor
    def make
      original_path = File.expand_path(@file.path)

      image_optim           = ImageOptim.new(pngcrush: false, pngout: false, advpng: false, jpegoptim: false, gifsicle: false)
      compressed_file_path  = image_optim.optimize_image(original_path)

      if compressed_file_path && File.exists?(compressed_file_path)
        result = File.open(compressed_file_path)
      else
        raise Paperclip::Error, "compressing #{@attachment.original_filename} failed: the compressed temporary file does not exist"
      end

      result
    end
  end
end