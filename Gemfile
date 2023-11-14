source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'pg', '~> 1.1'
gem 'rails', '~> 7.0.5'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'devise'
gem 'devise-jwt'
gem 'rack-cors'
gem 'rails-i18n', '~> 7.0.0' # For 7.0.0

group :development do
  gem 'brakeman'
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-minitest', require: false
  gem 'rubocop-rails', require: false
  gem 'rubycritic', '4.7.0', require: false
end

group :development, :test do
  gem 'bullet'
  gem 'factory_bot_rails'

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'simplecov', require: false

  gem 'shoulda-context', '~> 2.0'
  gem 'shoulda-matchers', '~> 4.3.0'
end
