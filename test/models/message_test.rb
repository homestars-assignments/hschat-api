require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test 'All test messages should be loaded' do
    assert_equal(Message.all.length, 23)
  end
end
