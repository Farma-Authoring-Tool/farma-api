require 'support/simplecov'
require 'support/bullet'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include BulletHelper
  include ActionsMessages
  include Devise::Test::IntegrationHelpers

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  parallelize_setup do |worker|
    SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}" if ENV['COVERAGE']
  end

  parallelize_teardown do |_worker|
    SimpleCov.result if ENV['COVERAGE']
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end

module RESPONSE
  module Type
    JSON = 'application/json; charset=utf-8'.freeze
  end
end
