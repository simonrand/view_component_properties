# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'view_component_properties/version'

Gem::Specification.new do |spec|
  spec.name          = 'view_component_properties'
  spec.version       = ViewComponentProperties::VERSION
  spec.authors       = ['Simon Rand']
  spec.email         = ['simonrand@gmail.com']

  spec.summary       = 'Constrained properties for ViewComponent'
  spec.homepage      = 'https://github.com/simonrand/view_component_properties'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files         = Dir['CHANGELOG.md', 'LICENSE.txt', 'README.md', 'lib/**/*']
  spec.require_paths = ['lib']

  spec.add_dependency             'view_component', '~> 2.0'
  spec.add_runtime_dependency     'capybara', '~> 3'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '= 0.81'
  spec.add_development_dependency 'rubocop-rails', '= 2.5.2'
end
