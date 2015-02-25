require 'paperclip'
require 'image_optim'

module Paperclip
  class PaperclipOptimizer < Processor
    def self.default_options
      @default_options ||= ::PaperclipOptimizer::DEFAULT_OPTIONS
    end

    def self.default_options=(new_options)
      @default_options = new_options
    end

    def make
      src_path = File.expand_path(@file.path)

      if optimizer_options[:verbose]
        Paperclip.logger.info "optimizing #{src_path} with settings: #{optimizer_options.inspect}"

        old_stderr  = $stderr
        $stderr     = ::PaperclipOptimizer::StdErrCapture.new(Paperclip.logger)
      end

      begin
        image_optim           = ImageOptim.new(optimizer_options)
        compressed_file_path  = image_optim.optimize_image(src_path)
      ensure
        $stderr = old_stderr if optimizer_options[:verbose]
      end

      if compressed_file_path && File.exist?(compressed_file_path)
        return File.open(compressed_file_path)
      else
        return File.new(@file.path)
      end
    end

      protected

    def optimizer_options
      optimizer_global_options
        .deep_merge(optimizer_instance_options)
        .deep_merge(optimizer_style_options)
        .delete_if { |_key, value| value.nil? }
    end

      private

    def optimizer_global_options
      self.class.default_options
    end

    def optimizer_instance_options
      instance_options = @attachment.options.fetch(:paperclip_optimizer, {})
      instance_options.respond_to?(:call) ? instance_options.call(@attachment) : instance_options
    end

    def optimizer_style_options
      @options.fetch(:paperclip_optimizer, {})
    end
  end
end
