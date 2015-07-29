source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '4.2.1'

# front-end
gem 'sass-rails', '~> 5.0'
gem 'compass', '~> 1.0.3'
gem 'haml', '~> 4.0.6'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'bourbon', '~> 4.2.3'
gem 'bootstrap-sass', '~> 3.3.5'
gem 'jquery-rails'
gem 'nav_lynx', '~> 1.1.1'
gem 'turbolinks'
gem 'bower-rails', '~> 0.9.2'

# file handling
gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick', '~> 4.2.7'

# security & auth
gem 'sorcery', '~> 0.9.1'
gem 'bcrypt', '~> 3.1.7'

# payment
gem 'stripe', '~> 1.22.0'

# search
gem 'elasticsearch-model', '~> 0.1.7'
gem 'elasticsearch-rails', '~> 0.1.7'

# mailers
gem 'mandrill-api', '~> 1.0.53'

# miscelaneous
gem 'country_select', '~> 2.2.0'
gem 'countries'
gem 'kaminari', '~> 0.16.3'
gem 'social_shares', '~> 0.2.5'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'figaro', '~> 1.1.1'

# performance & monitoring
gem 'skylight'
gem 'airbrake'

# server & deployment
gem 'puma', '~> 2.11.3'
gem 'pg', '~> 0.18.2'

# gem 'capistrano-rails', group: :development

group :development do
  gem 'stackprof', '~> 0.2.7'
  gem 'derailed_benchmarks', '~> 1.0.1'
  gem 'ffaker', '~> 2.0.0'
  gem 'better_errors'
  gem 'meta_request'
end

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 3.3.1'
  gem 'spring', '~> 1.3.6'
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'capybara', '~> 2.4.4'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'guard-rspec', '~> 4.6.0'
end

group :production do
  gem 'rails_12factor', '~> 0.0.3'
  gem 'fog', '~> 1.31.0'
  gem 'bonsai-elasticsearch-rails', '~> 0.0.4'
end
