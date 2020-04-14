# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in view_component_properties.gemspec
gemspec

rails_version = (ENV['RAILS_VERSION'] || '6.0.2.2').to_s

gem 'rails', rails_version == 'master' ? { github: 'rails/rails' } : rails_version
