# coding: utf-8
require 'bundler/setup'
require 'rails/browser_detector'
require 'pry-byebug'

require 'simplecov'
SimpleCov.start do
  minimum_coverage 85
  add_filter 'lib/rails-browser_detector/engine.rb'
  add_filter 'lib/rails-browser_detector/version.rb'
  add_filter 'lib/rails-browser_detector.rb'
end

require 'combustion'
Combustion.initialize! :action_controller
