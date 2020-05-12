# frozen_string_literal: true

require 'test_helper'

class ViewComponentPropertiesTest < ViewComponent::TestCase
  def test_that_it_has_a_version_number
    assert_not_nil ::ViewComponentProperties::VERSION
  end

  def test_it_renders_the_component
    render_inline(InlineComponent.new) do
      'inline component'
    end

    assert_selector('div', text: 'inline component')
  end

  def test_it_adds_the_call_helper
    assert_respond_to(InlineComponent.new, :call)
  end

  def test_it_adds_the_property_classes_method
    assert_respond_to(InlineComponent.new, :example_classes)
  end

  def test_it_applies_properties_with_single_values
    render_inline(InlineComponent.new(example: :second)) do
      'inline component'
    end

    assert_selector("div[class='class2']", text: 'inline component')
  end

  def test_it_applies_properties_with_hash_values
    render_inline(InlineComponent.new(example: { default: :second, lg: :first })) do
      'inline component'
    end

    assert_selector("div[class='class2 lg:class1']", text: 'inline component')
  end

  def test_it_raises_if_raise_on_error_config_is_enabled
    ViewComponentProperties.config.raise_error_for_invalid_property_values = true
    exception = assert_raises ViewComponentProperties::PropertyError do
      render_inline(InlineComponent.new(example: { default: :nonsense }))
    end

    assert_equal exception.message, 'Invalid property value "nonsense" for Properties::Example'
    ViewComponentProperties.reset
  end

  def test_it_does_not_raise_if_raise_on_error_config_is_disabled
    ViewComponentProperties.config.raise_error_for_invalid_property_values = false
    render_inline(InlineComponent.new) do
      'inline component'
    end

    assert_selector('div', text: 'inline component')
    ViewComponentProperties.reset
  end
end
