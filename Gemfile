source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
  gem 'jquery-ui-rails'
end

gem 'jquery-rails'
gem 'friendly_id'

# To use ActiveModel has_secure_password
 gem 'bcrypt-ruby', '~> 3.0.0'
 gem 'omniauth-github'
 gem 'omniauth-openid'

group :development, :test do
  # gem 'debugger'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'sqlite3'
  gem 'thin'
  gem 'letter_opener'
  gem 'foreman'
  gem "factory_girl_rails", "~> 4.0"
end

group :development do
  gem 'pry'
  gem "binding_of_caller", "~> 0.7.1"
  gem 'better_errors'
end

gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'
gem 'whenever', :require => false

gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"
gem 'exception_notification'
gem 'postmark-rails'


gem 'redcarpet'

#caching
gem 'dalli'

#chron jobs
gem 'whenever', :require => false

#stripe
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'capistrano-ext'

# To use debugger
# gem 'debugger'

gem 'octokit', :github => 'adamjonas/octokit'
gem 'will_paginate'
