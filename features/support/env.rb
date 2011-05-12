ENV["RAILS_ENV"] ||= "test"

require 'rails/all'
Bundler.require

require 'diesel/testing'
require 'diesel/testing/integration'

require 'cucumber/formatter/unicode'
require 'cucumber/rails/world'
require 'cucumber/rails/active_record'
require 'cucumber/web/tableish'
require 'capybara/rails'
require 'capybara/cucumber'
require 'capybara/session'

Capybara.default_selector = :css
Capybara.save_and_open_page_path = 'tmp'
Cucumber::Rails::World.use_transactional_fixtures = true

Before do
  @aruba_timeout_seconds = 60
end
