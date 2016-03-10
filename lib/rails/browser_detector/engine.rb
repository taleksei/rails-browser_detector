# coding: utf-8
require 'rails'

module Rails
  module BrowserDetector
    class Engine < ::Rails::Engine
      config.autoload_paths << "#{config.root}/lib"
      config.autoload_paths << "#{config.root}/app/controllers/concerns" if Rails.version.to_i < 4
    end
  end
end
