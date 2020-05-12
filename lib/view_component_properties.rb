# frozen_string_literal: true

require 'action_view'
require 'active_support/dependencies/autoload'

module ViewComponentProperties
  extend ActiveSupport::Autoload

  autoload :Config, 'view_component_properties/config'
  autoload :BaseComponent, 'view_component_properties/base_component'
  autoload :PropertyError, 'view_component_properties/property_error'

  module Properties
    autoload :Base, 'view_component_properties/properties/base'
    autoload :Helpers, 'view_component_properties/properties/helpers'
  end

  class << self
    attr_writer :config
  end

  def self.config
    @config ||= Config.new
  end

  def self.reset
    @configuration = Config.new
  end

  def self.configure
    yield(config)
  end
end
