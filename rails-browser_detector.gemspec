# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails/browser_detector/version'

Gem::Specification.new do |spec|
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.name          = 'rails-browser_detector'
  spec.version       = ::Rails::BrowserDetector::VERSION
  spec.authors       = %w(Fyodor Parmanchukov)
  spec.email         = %w(rezerbit@gmail.com)
  spec.summary       = %q{Browser detector}
  spec.description   = %q{Browser compatibility definition}
  spec.homepage      = 'https://github.com/abak-press/rails-browser_detector'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_runtime_dependency 'rails', '>= 4.0.13', '< 5.0'
  spec.add_runtime_dependency 'user_agent_parser', '>= 2.3.0'

  spec.add_development_dependency 'bundler', '>= 1.7'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '>= 3.9.0'
  spec.add_development_dependency 'appraisal', '>= 1.0.2'
  spec.add_development_dependency 'combustion'
  spec.add_development_dependency 'simplecov', '>= 0.10.0'
  spec.add_development_dependency 'pry-byebug'
end
