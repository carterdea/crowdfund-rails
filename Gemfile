source 'https://rubygems.org'
ruby '2.5.1'

gem 'rails', '~> 6.1', '>= 6.1.7.3'

# front-end
gem 'bootstrap-sass', '~> 3.4.1'
gem 'bourbon', '~> 4.2.7'
gem 'bower', '~> 0.0.5'
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'
gem 'compass', '~> 1.0.3'
gem 'hamlit', '~> 2.7'
gem 'jquery-rails', '~> 4.4', '>= 4.4.0'
gem 'jquery-turbolinks', '~> 2.1.0'
gem 'nav_lynx', '~> 1.1.1'
gem 'sass-rails', '~> 6.0', '>= 6.0.0'
# gem 'sassc', '~> 1.8'
gem 'turbolinks', '~> 5.0'
gem 'uglifier', '~> 3.0'

# charts
gem 'groupdate', '~> 3.2', '>= 3.2.1'

# file handling
gem 'carrierwave', '~> 1.3.2'
gem 'mini_magick', '~> 4.9'

# security & auth
gem 'bcrypt', '~> 3.1'
gem 'cancancan', '~> 1.15'
gem 'has_secure_token', '~> 1.0.0'
gem 'sorcery', '~> 0.15.0'

# payment
gem 'stripe', '~> 1.51'

# search
gem 'elasticsearch-model', '~> 0.1.9'
gem 'elasticsearch-rails', '~> 0.1.9'

# cache
gem 'hiredis', '~> 0.6.1'
gem 'readthis', '~> 2.2' # cool new redis client http://sorentwo.com/2015/07/20/high-performance-caching-with-readthis.html

# mailers
gem 'mandrill-api', '~> 1.0.53'

# background jobs
gem 'sidekiq', '~> 6.2', '>= 6.2.1'

# miscelaneous
gem 'country_select', '~> 2.5'
gem 'countries', require: 'countries/global'
gem 'figaro', '~> 1.1.1'
gem 'jbuilder', '~> 2.7', '>= 2.7.0'
gem 'kaminari', '~> 1.2.1'
gem 'redcarpet', '~> 3.5', '>= 3.5.1'
gem 'ruby-oembed', '~> 0.10.1'
gem 'sequenced', '~> 3.1', '>= 3.1.1'
gem 'sdoc', '~> 1.0.0', group: :doc
gem 'social_shares', '~> 0.3.4'
gem 'tumblr_client', '~> 0.8.5'

# localization
gem 'rails-i18n', '~> 6.0.0' # needs Rails 5 to update

# performance & monitoring
gem 'airbrake', '~> 5.6'
gem 'skylight'

# server & deployment
gem 'pg', '~> 0.18.4'
gem 'puma', '~> 4.3', '>= 4.3.12'

group :development do
  gem 'annotate', '~> 2.7', '>= 2.7.5'
  gem 'better_errors', '>= 2.8.0'
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'brakeman', '~> 3.3'
  gem 'bullet', '~> 5.7', '>= 5.7.5'
  gem 'derailed_benchmarks', '~> 1.3', '>= 1.3.4'
  gem 'gem_bench', require: false
  gem 'immigrant', '~> 0.3.6'
  gem 'letter_opener', '~> 1.6', '>= 1.6.0'
  gem 'memory_profiler', '~> 0.9.6'
  gem 'meta_request', '~> 0.7.0'
  gem 'populator', '~> 1.0.0'
  gem 'sinatra', '~> 2.2.3' # for Sidekiq monitoring https://github.com/mperham/sidekiq/wiki/Monitoring
  gem 'rails-footnotes', '~> 4.1', '>= 4.1.8'
  gem 'rails_best_practices', '~> 1.19', '>= 1.19.2'
  # benchmarking
  gem 'stackprof', '~> 0.2.9'
  gem 'web-console', '~> 3.3', '>= 3.3.0'
end

group :development, :test do
  gem 'ffaker', '~> 2.2'
  gem 'jazz_fingers', '~> 4.0'
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
  gem 'spring', '~> 1.7'
end

group :test do
  gem 'capybara', '~> 3.31', '>= 3.31.0'
  gem 'capybara-screenshot', '~> 1.0', '>= 1.0.24'
  gem 'capybara-webkit', '~> 1.15', '>= 1.15.1'
  gem 'codeclimate-test-reporter', '~> 0.6.0', require: nil
  gem 'database_cleaner', '~> 1.5'
  gem 'factory_girl_rails', '~> 4.9', '>= 4.9.0'
  gem 'guard-rspec', '~> 4.7'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
  gem 'webmock', '~> 2.3', '>= 2.3.2'
  gem 'vcr', '~> 3.0'
end

group :production do
  gem 'bonsai-elasticsearch-rails', '~> 0.0.4'
  gem 'fog', '~> 1.42', '>= 1.42.0'
  gem 'rails_12factor', '~> 0.0.3'
end
