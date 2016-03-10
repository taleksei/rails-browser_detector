# coding: utf-8
require 'bundler/setup'
require 'rails/browser_detector'

require 'simplecov'
SimpleCov.start do
  minimum_coverage 85

  add_filter '/spec/'
  add_filter 'lib/rails-browser_detector/engine.rb'
  add_filter 'lib/rails-browser_detector/version.rb'
  add_filter 'lib/rails-browser_detector.rb'
end

require 'factory_girl_rails'

require 'combustion'
Combustion.initialize! :action_controller

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.backtrace_exclusion_patterns = [%r{lib/rspec/(core|expectations|matchers|mocks)}]
  config.color = true
  config.order = 'random'
end
