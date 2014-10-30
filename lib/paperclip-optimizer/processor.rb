require "paperclip"
require "image_optim"

module Paperclip
  class PaperclipOptimizer < Processor
    def self.default_settings
      @default_settings ||= {
        pngcrush: false,
        pngout: false,
        advpng: false,
        jpegoptim: false,
        gifsicle: false
      }
    end

    def make
      settings = (@options[:paperclip_optimizer] || {}).reverse_merge(self.class.default_settings)

      src_path = File.expand_path(@file.path)

      if settings[:verbose]
        Paperclip.logger.info "optimizing #{src_path} with settings: #{settings.inspect}"

        old_stderr  = $stderr
        $stderr     = ::PaperclipOptimizer::StdErrCapture.new(Paperclip.logger)
      end

      begin
        image_optim           = ImageOptim.new(settings)
        compressed_file_path  = image_optim.optimize_image(src_path)
      ensure
        $stderr = old_stderr if settings[:verbose]
      end

      if compressed_file_path && File.exists?(compressed_file_path)
        return File.open(compressed_file_path)
      else
        return @file
      end
    end
  end
end