ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  self.use_instantiated_fixtures = true # Refer as local variables to all items in fixtures...
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def auth(user = nil)
    user = @kimura if user.nil?
    { 'Authorization': JsonWebToken.encode(user_id: user.id) }
  end
end
