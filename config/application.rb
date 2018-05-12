# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SecurellaApi
  class Application < Rails::Application
    config.load_defaults 5.1

    config.api_only = true

    config.active_job.queue_adapter = :sidekiq

    #   config.middleware.insert_before 0, Rack::Cors do
    #     allow do
    #       origins '127.0.0.1:3001'
    #       resource '*', headers: :any, methods: [:get, :post, :options, :put, :delete], credentials: true
    #     end
    #
    #     allow do
    #       origins 'http://127.0.0.1:3001'
    #       resource '*', headers: :any, methods: [:get, :post, :options, :put, :delete], credentials: true
    #     end
    #
    #     allow do
    #       origins 'localhost:3001'
    #       resource '*', headers: :any, methods: [:get, :post, :options, :put, :delete], credentials: true
    #     end
    #
    #     allow do
    #       origins 'http://localhost:3001'
    #       resource '*', headers: :any, methods: [:get, :post, :options, :put, :delete], credentials: true
    #     end
    #
    #     allow do
    #       origins 'http://172.21.0.1:3001'
    #       resource '*', headers: :any, methods: [:get, :post, :options, :put, :delete], credentials: true
    #     end
    #
    #     allow do
    #       origins 'http://localhost:3002'
    #       resource '*', headers: :any, methods: [:get, :post, :options, :put, :delete]
    #     end
    #   end
  end
end
