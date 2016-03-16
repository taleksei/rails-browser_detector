module Rails
  module BrowserDetector
    module BrowserCompatible
      extend ActiveSupport::Concern

      included do
        helper_method :browser_old?
      end

      protected

      def browser_old?
        return @browser_old if defined? @browser_old

        @browser_old =
          Rails.application.config.compatible_browsers.any? do |browser, version|
            current_browser.family == browser && current_browser.version && current_browser.version.major.to_i < version
          end
      end

      def current_browser
        return @current_browser if defined? @current_browser

        @current_browser = ::Rails::BrowserDetector.detect(request.user_agent)
      end
    end
  end
end
