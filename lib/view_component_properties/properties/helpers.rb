module ViewComponentProperties
  module Properties
    class Helpers
      class << self
        def property_name_from_module(mod)
          # Assumes module begins with `Properties`
          mod.name.split('::')[1..-1].join.underscore
        end

        def classes_method_name_from_module(mod)
          "#{property_name_from_module(mod)}_classes"
        end
      end
    end
  end
end
