# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'factory_girl_rails'

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'spec'
end

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/json_expectations'

require 'shoulda/matchers'
require 'support/shoulda'
require 'support/database_cleaner'

def uri_host(uri)
  return nil if uri.nil?
  URI.parse(uri).host || uri
end

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
Dir[Rails.root.join('spec', 'shared', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  config.example_status_persistence_file_path = './spec/examples.txt'
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
