ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all


  include Devise::Test::IntegrationHelpers
  #include Devise::TestHelpers
  include Warden::Test::Helpers

  # Add more helper methods to be used by all tests here...


end
