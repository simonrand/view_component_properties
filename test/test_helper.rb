# frozen_string_literal: true

require 'bundler/setup'
require 'minitest/autorun'

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('config/environment.rb', __dir__)
require 'view_component/test_case'
