# ViewComponentProperties

Manage, constrain and use CSS class properties on [ViewComponent](https://github.com/github/view_component) components.

**Note:** At this point in time this should be considered a proof of concept.

ViewComponentProperties allows you to:

- apply tightly constrained CSS classes ("properties") to ViewComponents using properties defined once, but available to be applied anywhere
- quickly create simple ViewComponents using a provided base utility component

## Goals

The goal of ViewComponentProperties is to facilitate implementing a design system by providing well defined and clear constraints on the CSS that can be used to build HTML views with ViewComponents. When combined with a comprehensive CSS framework (such as [Tailwind CSS](https://tailwindcss.com)), once your components and properties have been defined, it should be possible to implement the design intent of a design system in a view while writing less HTML and/or CSS. (..maybe even none at all)

While not a requirement, the current version is somewhat built assuming usage of  [Tailwind CSS](https://tailwindcss.com) for styling.

## Compatibility

ViewComponentProperties depends on [ViewComponent](https://github.com/github/view_component) and therefore is intended to work with Ruby on Rails, v5.0+

## Installation

The gem has not yet been published but you can install in your app using by adding this to your `Gemfile`:

`gem 'view_component_properties', git: 'https://github.com/simonrand/view_component_properties.git'`

## Example usage

Ensure you have [ViewComponent](https://github.com/github/view_component) working in your Rails app.

First, define an `ApplicationComponent` which inherits from `ViewComponentProperties::BaseComponent`.

`app/components/application_component.rb`:

```ruby
class ApplicationComponent < ViewComponentProperties::BaseComponent
end
```

### Using the provided ViewComponentProperties "utility" template

`app/components/example_component.rb`:

```ruby
class ExampleComponent < ApplicationComponent
  private

  def tag_name # optional, :div is the default
    :p
  end
end
```

`ViewComponentProperties::BaseComponent` implements an inline template which simply returns our content wrapped in the defined `tag_name`, so using our `ExampleComponent` above:

```ruby
<%= render(ExampleComponent.new) do %>
  Hello, World!
<% end %>
```

Returns:

```html
<p>Hello, World!</p>
```

### Adding a margin bottom property to a component

Define our property and the allowed values in `app/components/properties/margin/bottom.rb`:

```ruby
module Properties
  module Margin
    module Bottom
      include ViewComponentProperties::Properties::Base

      # NOTE: mb-* are Tailwind CSS margin bottom utility classes, see
      #       https://tailwindcss.com/docs/margin/#add-margin-to-a-single-side
      CLASSES = {
        2 => 'mb-2',
        4 => 'mb-4'
      }
    end
  end
end
```

The path and module name defines the parameter name which will set the property on a component, so in the case of our margin bottom property, the parameter name will be `margin_bottom`.

Include our property on our `ExampleComponent`

`app/components/example_component.rb`:

```ruby
class ExampleComponent < ApplicationComponent
  include Properties::Margin::Bottom
end
```

Now we can apply our property to the component:

```ruby
<%= render(ExampleComponent.new(margin_bottom: 2)) do %>
  Hello, World!
<% end %>
```

Returning:

```html
<div class="mb-2">Hello, World!</div>
```

### Responsive properties

Responsive properties (again following Tailwind CSS conventions) are supported by passing a hash value for the property value. For example:

`app/components/example_component.rb`:

```ruby
class ExampleComponent < ApplicationComponent
  include Properties::Margin::Bottom # as per the "Adding a margin bottom property to a component" example above
end
```

```ruby
<%= render(ExampleComponent.new(margin_bottom: { default: 2, lg: 4 })) do %>
  Hello, World!
<% end %>
```

Returns:

```html
<div class="mb-2 lg:mb-4">Hello, World!</div>
```

## Invalid property values

By default passing invalid property values to will result in no class being returned:

`app/components/example_component.rb`:

```ruby
class ExampleComponent < ApplicationComponent
  include Properties::Margin::Bottom # as per the "Adding a margin bottom property to a component" example above
end
```

Now we can apply our property to the component:

```ruby
<%= render(ExampleComponent.new(margin_bottom: 1)) do %>
  Hello, World!
<% end %>
```

Returning:

```html
<div>Hello, World!</div>
```

However, for non-production environments it would be recommended that you raise an error on invalid property values, you can do this by setting the `raise_error_for_invalid_property_values` configuration option to true:

Now we can apply our property to the component:

```ruby
ViewComponentProperties.config.raise_error_for_invalid_property_values = true

<%= render(ExampleComponent.new(margin_bottom: 1)) do %>
  Hello, World!
<% end %>

# `margin_bottom: 1` will raise with ViewComponentProperties::PropertyError
```

It is **not** recommended to raise exceptions in production environments.

## TODO

- [ ] Continue exploring this proof of concept

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/simonrand/view_component_properties. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
