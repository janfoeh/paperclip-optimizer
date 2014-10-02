
require 'paperclip-optimizer/version'
require 'paperclip-optimizer/processor'

module PaperclipOptimizer
  DEFAULT_SETTINGS = {
    pngcrush: false,
    pngout: false,
    advpng: false,
    jpegoptim: false,
    gifsicle: false
  }.freeze

  # Helper class for capturing ImageOptims error output and redirecting it
  # to Paperclips logger instance
  class StdErrCapture
    def initialize(logger, log_level = :error)
      @logger     = logger
      @log_level  = log_level
    end

    def write(string)
      @logger.send(@log_level, string)
    end

    alias_method '<<', :write

    def flush; end
  end

end
