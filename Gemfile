source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.0"

gem "rails", "~> 6.0.3", ">= 6.0.3.4"
gem "puma", "~> 4.1"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 4.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "mysql2", "~> 0.4.10"
gem "rails-i18n"
gem "bcrypt"
gem "config"
gem "kaminari"
gem "bootstrap-kaminari-views"
gem "cocoon"
gem "toastr-rails"
gem "factory_bot_rails"
gem "devise"
gem "figaro"
gem "cancancan"
gem "ransack"
gem "omniauth"
gem "omniauth-facebook"
gem "sidekiq"
gem "chosen-rails"
gem "grape"
gem "grape-active_model_serializers"
gem "jwt"
gem "grape_on_rails_routes"
gem "grape-swagger"
gem "grape-swagger-rails"
gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  gem "rails-controller-testing"
  gem "pry-rails"
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "database_cleaner"
  gem "faker"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "rspec-rails", "~> 4.0.1"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "simplecov-rcov"
  gem "rspec-sidekiq"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
