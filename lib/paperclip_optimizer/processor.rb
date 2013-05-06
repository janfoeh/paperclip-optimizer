require "paperclip"
require "image_optim"

module Paperclip
  class PaperclipOptimizer < Processor
    def make
      @file
    end
  end
end