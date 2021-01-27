require 'rails'
require 'rails/browser_detector/version'
require 'rails/browser_detector/engine'

require 'user_agent_parser'

module Rails
  module BrowserDetector
    class << self
      def detect(user_agent)
        user_agent_parser.parse(user_agent)
      end

      private

      # Internal: Возвращает экземпляр парсера, использующий кастомный файл с регулярками.
      #   Дефолтный файл не используется, потому что в нем содержится много правил.
      #   Кастомный файл - это дефолтный, из которого вырезаны ненужные для нас правила.
      #
      # Examples
      #   browser = Rails::BrowserDetector.user_agent_parser.parse(request.user_agent)
      #   browser.family #=> 'IE'
      #   browser.version.major #=> 10
      #
      # Returns an instance of UserAgentParser::Parser.
      def user_agent_parser
        return @user_agent_parser if defined? @user_agent_parser

        patterns_path = "#{Gem.loaded_specs['rails-browser_detector'].gem_dir}/config/regexes.yml"
        @user_agent_parser = ::UserAgentParser::Parser.new(patterns_path: patterns_path)
      end
    end
  end
end
