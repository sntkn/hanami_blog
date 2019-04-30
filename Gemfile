source 'https://rubygems.org'

gem 'hanami', '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'rake'

gem 'pg'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'hanami-webconsole'
  gem 'shotgun', platforms: :ruby

  gem "brakeman"
  gem "bullet"
  gem "bundler-audit"
  gem "letter_opener"
  gem "pre-commit", require: false
  gem "rubocop"
  gem "solargraph"
end

group :test, :development do
  gem 'dotenv', '~> 2.4'

  gem "better_errors"
  gem "binding_of_caller"
  gem "pry"
  gem "tapp"
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'rspec'
  gem 'simplecov'
  gem "timecop"
end

group :production do
  # gem 'puma'
end
