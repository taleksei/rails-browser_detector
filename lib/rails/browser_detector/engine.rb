require 'rails'

module Rails
  module BrowserDetector
    class Engine < ::Rails::Engine
      config.autoload_paths << "#{config.root}/lib"
    end
  end
end
