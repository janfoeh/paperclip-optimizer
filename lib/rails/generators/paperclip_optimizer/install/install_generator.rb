module PaperclipOptimizer
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
   
    desc "creates an initializer file at config/initializers for setting global options"
   
    def create_initializer
      copy_file "initializer.rb", "config/initializers/paperclip_optimizer.rb"
    end
  end
end