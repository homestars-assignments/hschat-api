require "test_helper"

class UserTest < ActiveSupport::TestCase
  self.use_instantiated_fixtures = true # Refer as local variables to all items in fixtures...

  test 'register messages' do
    assert_equal(@kimura.sent_messages.length, 2)
  end
end

