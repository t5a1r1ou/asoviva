# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.5'
gem 'redis-rails'

gem 'bootsnap', '>= 1.1.0', require: false

gem 'materialize-sass', '~> 1.0.0'
gem 'material_icons'
gem 'devise', '>= 4.7.1'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem 'kaminari'
gem 'mini_magick'
gem 'aws-sdk-s3', require: false
gem 'rubocop'
gem 'ransack'
gem 'pry-rails'
gem 'pry-byebug'
gem 'enum_help'
gem 'meta-tags'
gem 'settingslogic'
gem 'mechanize'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 3.8.0'
  gem 'factory_bot_rails', '~> 4.10.0'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'bullet'
end

group :test do
  gem 'capybara', '~> 3.28'
  gem 'webdrivers'
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
