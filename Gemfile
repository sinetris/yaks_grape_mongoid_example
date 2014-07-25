source 'https://rubygems.org'

gem 'rack'
gem 'pry'
gem "mongoid", "~> 4.0.0"
gem 'bcrypt'
gem 'yaks', github: 'plexus/yaks'

group :development, :test do
  gem 'rack-test'
  gem "factory_girl", "~> 4.0"
end

group :test do
  gem 'rspec', '~> 3.0'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'mongoid-rspec', github: 'pcreux/mongoid-rspec', branch: 'mongo-4-rspec-3'
end
