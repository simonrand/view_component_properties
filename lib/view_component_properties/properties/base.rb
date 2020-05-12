# frozen_string_literal: true

module ViewComponentProperties
  module Properties
    # This module adds the property functionality, by defining the property
    # methods on the component.
    module Base
      PROPERTY_INITIALIZE_PARAMS_CONSTANT_NAME = 'INITIALIZE_PARAMS'
      INVALID_PROPERTY_NAMES = %w[property].freeze

      def self.included(klass)
        property_name = Properties::Helpers.property_name_from_module(klass)

        if INVALID_PROPERTY_NAMES.include?(property_name)
          raise PropertyError, "'Property' is reserved word and cannot be used for a property name"
        end

        module_eval <<-RUBY, __FILE__, __LINE__ + 1
          # Automatically add the property to the list of params to auto initialize
          # in the component (const_set will only create a new constant if not already defined)
          klass.const_set('#{PROPERTY_INITIALIZE_PARAMS_CONSTANT_NAME}', %i[#{property_name}])

          # Define the property_name_classes method
          def #{property_name + '_classes'}
            return unless @#{property_name}

            if @#{property_name}.is_a?(Hash)
              return build_responsive_class_value(@#{property_name}, ::#{klass}::CLASSES, '#{klass}')
            end

            class_value(@#{property_name}, ::#{klass}::CLASSES, '#{klass}')
          end
        RUBY
      end

      private

      def build_responsive_class_value(values, available_values, class_name)
        initial_output = if values[:default]
                           [class_value(values.delete(:default), available_values, class_name)]
                         else
                           []
                         end

        values.each_with_object(initial_output) do |(prefix, value), output|
          # NOTE: This is very Tailwind specific, it would be better to make
          #       this configurable to be used with other responsive approaches.
          output << "#{prefix}:#{class_value(value, available_values, class_name)}"
        end.compact.join(' ')
      end

      def class_value(value, available_values, class_name)
        class_value = available_values[value]
        if ViewComponentProperties.config.raise_error_for_invalid_property_values && class_value.nil?
          raise PropertyError, "Invalid property value \"#{value}\" for #{class_name}"
        end

        class_value
      end
    end
  end
end
