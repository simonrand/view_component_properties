module ViewComponentProperties
  module Properties
    module Base
      PROPERTY_INITIALIZE_PARAMS_CONSTANT_NAME = 'INITIALIZE_PARAMS'

      def self.included(klass)
        property_name = Properties::Helpers.property_name_from_module(klass)
        method_name =  property_name + '_classes'

        module_eval <<-RUBY
          # Automatically add the property to the list of params to auto initialize
          # in the component (const_set will only create a new constant if not already defined)
          # TODO: Fix redefinition warnings
          klass.const_set('#{PROPERTY_INITIALIZE_PARAMS_CONSTANT_NAME}', %i[#{property_name}])

          # Define the property_name_classes method
          def #{method_name}
            ::#{klass}::CLASSES[@#{property_name}]
          end
        RUBY
      end
    end
  end
end
