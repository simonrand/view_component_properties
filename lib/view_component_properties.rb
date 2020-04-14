# frozen_string_literal: true

require 'action_view'
require 'active_support/dependencies/autoload'

module ViewComponentProperties
  extend ActiveSupport::Autoload

  autoload :BaseComponent, 'view_component_properties/base_component'

  module Properties
    autoload :Base, 'view_component_properties/properties/base'
    autoload :Helpers, 'view_component_properties/properties/helpers'
  end
end
