require "paperclip"
require "image_optim"

module Paperclip
  class PaperclipOptimizer < Processor
    def make
      src_path = File.expand_path(@file.path)

      settings = (@options[:paperclip_optimizer] || {}).reverse_merge(::PaperclipOptimizer::DEFAULT_SETTINGS)

      image_optim           = ImageOptim.new(settings)
      compressed_file_path  = image_optim.optimize_image(src_path)

      if compressed_file_path && File.exists?(compressed_file_path)
        result = File.open(compressed_file_path)
      else
        raise Paperclip::Error, "compressing #{@attachment.original_filename} failed: ImageOptim did not return a compressed image"
      end

      result
    end
  end
end