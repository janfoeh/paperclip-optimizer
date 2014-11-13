# Set global optimisation options for all Paperclip models

# By default, image_optim enables all the compression binaries it supports and
# requires them to be present on your system, failing if one is actually missing.

# We disable everything by default and ignore missing ones with `skip_missing_workers`.
# This way, should a new version add support for a library we do not yet disable here,
# things won't suddenly break.

Paperclip::PaperclipOptimizer.default_options = {
  skip_missing_workers: true,
  advpng: false,
  gifsicle: false,
  jhead: false,
  jpegoptim: false,
  jpegrecompress: false,
  jpegtran: false,
  optipng: false,
  pngcrush: false,
  pngout: false,
  pngquant: false,
  svgo: false
}

# All available image_optim options. See https://github.com/toy/image_optim for more information

# Paperclip::PaperclipOptimizer.default_options = {
#   skip_missing_workers: false, # Skip workers with missing or problematic binaries (defaults to false)
#   nice: 10,             # Nice level (defaults to 10)
#   threads: 1,           # Number of threads or disable (defaults to number of processors)
#   verbose: false,       # Verbose output (defaults to false)
#   pack: nil,            # Require image_optim_pack or disable it, by default image_optim_pack will be used if available,
#                         # will turn on :skip-missing-workers unless explicitly disabled (defaults to nil)
#   allow_lossy: false,   # Allow lossy workers and optimizations (defaults to false)
#   advpng: {
#     leve: 4             # Compression level: 0 - don't compress, 1 - fast, 2 - normal, 3 - extra, 4 - extreme (defaults to 4)
#   },
#   gifsicle: {
#     interlace: true,    # Interlace: true - interlace on, false - interlace off, nil - as is in original image
#                         # (defaults to running two instances, one with interlace off and one with on)
#     level: 3,           # Compression level: 1 - light and fast, 2 - normal, 3 - heavy (slower) (defaults to 3)
#     careful: false      # Avoid bugs with some software (defaults to false)
#   },
#   jhead: true,          # no options
#   jpegoptim: {
#     strip: :all,        # List of extra markers to strip: :comments, :exif, :iptc, :icc or :all (defaults to :all)
#     max_quality: 100    # Maximum image quality factor 0..100 (defaults to 100)
#   },
#   jpegrecompress: {
#     quality: 3          # JPEG quality preset: 0 - low, 1 - medium, 2 - high, 3 - veryhigh (defaults to 3)  
#   },
#   jpegtran: {
#     copy_chunks: false, # Copy all chunks (defaults to false)
#     progressive: true,  # Create progressive JPEG file (defaults to true)
#     jpegrescan: false   # Use jpegtran through jpegrescan, ignore progressive option (defaults to false) 
#   },
#   optipng: {
#     level: 6,           # Optimization level preset: 0 is least, 7 is best (defaults to 6)
#     interlace: false    # Interlace: true - interlace on, false - interlace off, nil - as is in original image (defaults to false)
#   },
#   pngcrush: {
#     chunks: :alla,      # List of chunks to remove or :alla - all except tRNS/transparency or
#                         # :allb - all except tRNS and gAMA/gamma (defaults to :alla)
#     fix: false,         # Fix otherwise fatal conditions such as bad CRCs (defaults to false)
#     brute: false        # Brute force try all methods, very time-consuming and generally not worthwhile (defaults to false)
#   },
#   pngout: {
#     copy_chunks: false, # Copy optional chunks (defaults to false)
#     strategy: 0         # Strategy: 0 - xtreme, 1 - intense, 2 - longest Match, 3 - huffman Only, 4 - uncompressed (defaults to 0)
#   },
#   pngquant: {
#     quality: 100..100,  # min..max - don't save below min, use less colors below max (both in range 0..100; in yaml - !ruby/range 0..100) (defaults to 100..100)
#     speed: 3            # speed/quality trade-off: 1 - slow, 3 - default, 11 - fast & rough (defaults to 3)
#   },
#   svgo: true            # no options
# }