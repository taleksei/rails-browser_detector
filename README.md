# Rails::BrowserDetector

<a href="http://dolly.railsc.ru/projects/146/builds/latest/?ref=master"><img src="http://dolly.railsc.ru/badges/abak-press/rails-browser_detector/master" height="18"></a>

Identification of outdated browsers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-browser_detector'
```

Add `congig/initializers/rails-browser_detector.rb` and include BrowserCompatible into needed controllers:

```ruby
::ApplicationController.send :include, ::Rails::BrowserDetector::BrowserCompatible

Rails.application.config.compatible_browsers = {
  'Chrome'         => 45,
  'Yandex Browser' => 13,
  'Opera'          => 32,
  'Firefox'        => 42,
  'IE'             => 10,
  'Safari'         => 8
}
```

## Usage

Use controller/helper methods:
```ruby
browser_old? #=> true
```

## Contributing

1. Fork it ( https://github.com/abak-press/rails-browser_detector/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
