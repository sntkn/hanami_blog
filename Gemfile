source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'

gem 'pg'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'

  gem "brakeman"
  gem "bullet"
  gem "bundler-audit"
  gem "letter_opener"
  gem "pre-commit", require: false
  gem "solargraph"
end

group :test, :development do
  gem 'dotenv', '~> 2.4'

  gem "better_errors"
  gem "binding_of_caller"
  gem "tapp"
  gem "pry"
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'simplecov'
end

group :production do
  # gem 'puma'
end
