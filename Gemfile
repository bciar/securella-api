# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'

gem 'pg'
gem 'puma'
gem 'sidekiq'

gem 'dotenv-rails'
gem 'jbuilder', '~> 2.5'
gem 'responders'

gem 'brakeman', require: false
gem 'devise'
gem 'devise_token_auth'
gem 'fog-aws'
gem 'omniauth-facebook'
gem 'rack-cors', require: 'rack/cors'

gem 'aws-sdk', '~> 2.3'
gem 'geocoder'
gem 'paperclip'

group :development, :test do
  gem 'annotate'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'ci_reporter'
  gem 'ci_reporter_rspec'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'factory_girl_rails', require: false
  gem 'faker'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'rspec-json_expectations'
  gem 'rspec-legacy_formatters'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '3.0.1' # 3.1.0 is broken, wait until 3.1.1 is released
  gem 'simplecov'
  gem 'simplecov-rcov'
end

group :development do
  gem 'docker-sync'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
