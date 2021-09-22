# frozen_string_literal: true

module Rails
  module BrowserDetector
    module BrowserCompatible
      extend ActiveSupport::Concern

      APPLE_BRAND_NAME = 'Apple'
      private_constant :APPLE_BRAND_NAME

      WINDOWS_XP_NAME = 'Windows XP'
      private_constant :WINDOWS_XP_NAME

      included do
        helper_method :browser_old?
        helper_method :apple_device?
        helper_method :win_xp?
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

      def apple_device?
        return @apple_device if defined? @apple_device

        @apple_device = current_browser.device.brand == APPLE_BRAND_NAME
      end

      def win_xp?
        return @win_xp if defined? @win_xp

        @win_xp = current_browser.os.to_s == WINDOWS_XP_NAME
      end
    end
  end
end
