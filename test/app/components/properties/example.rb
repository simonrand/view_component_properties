# frozen_string_literal: true

module Properties
  module Example
    include ::ViewComponentProperties::Properties::Base

    CLASSES = {
      first: 'class1',
      second: 'class2'
    }.freeze
  end
end
