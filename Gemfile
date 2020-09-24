source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(File.expand_path('.ruby-version', __dir__)).chomp

# Core

gem 'rails', '~> 6.0.3.3'
gem 'mysql2'
gem 'puma'

# API

gem 'graphql'
gem 'graphql-errors'

# Assets

gem 'sass-rails'
gem 'uglifier'

# Security

gem 'bcrypt'
gem 'devise'
gem 'devise-jwt'
gem 'dotenv-rails'
gem 'rack-cors'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'awesome_print'
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'rspec-rails'
end

group :test do
  gem 'action-cable-testing'
  gem 'coveralls', '>= 0.8.23', require: false
  gem 'database_cleaner'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
  gem 'simplecov', require: false
end

group :development do
  gem 'graphiql-rails'
  gem 'spring'
  gem 'spring-watcher-listen'
end
