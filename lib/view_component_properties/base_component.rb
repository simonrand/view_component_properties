# frozen_string_literal: true

require 'view_component'

module ViewComponentProperties
  # BaseComponent wraps ViewComponent::Base, including defining a default
  # `call` method, which provides full support for properties for simple
  # single tag components.
  class BaseComponent < ViewComponent::Base
    def initialize(params = {})
      property_params(params).each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def call
      content_tag tag_name, attrs do
        content
      end
    end

    private

    def attrs
      attrs = {}
      attrs[:class] = classes if classes.any?
      attrs
    end

    def classes
      @classes ||= (specified_classes + property_classes).compact
    end

    def included_properties
      @included_properties ||= property_modules.select do |mod|
        # Module#parents will be removed in Rails 6.1,
        # but .module_parents does not exist in versions < 6.1
        parents = mod.respond_to?(:module_parents) ? mod.module_parents : mod.parents
        parents[-2] == ::Properties && mod != ViewComponentProperties::Properties::Base
      end
    end

    def property_classes
      included_properties.map do |mod|
        send(ViewComponentProperties::Properties::Helpers.classes_method_name_from_module(mod))
      end
    end

    def property_initialize_params
      included_properties.flat_map do |property|
        property.const_get(Properties::Base::PROPERTY_INITIALIZE_PARAMS_CONSTANT_NAME.to_sym)
      end.uniq
    end

    def property_modules
      self.class.ancestors.take_while { |a| a != Properties::Base } & self.class.included_modules
    end

    def property_params(params)
      params.select { |k, _| property_initialize_params.include?(k) }
    end

    def specified_classes
      []
    end

    def tag_name
      :div
    end
  end
end
