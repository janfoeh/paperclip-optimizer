require "paperclip-optimizer/version"
require "paperclip-optimizer/processor"

module PaperclipOptimizer
  DEFAULT_SETTINGS = {
    pngcrush: false, 
    pngout: false, 
    advpng: false, 
    jpegoptim: false, 
    gifsicle: false
  }.freeze
end