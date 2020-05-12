# frozen_string_literal: true

module ViewComponentProperties
  class Config
    attr_accessor :raise_error_for_invalid_property_values

    def initialize
      # Setting this to true in any live environments should be considered
      # _very_ dangerous, use with care.
      @raise_error_for_invalid_property_values = false
    end
  end
end
