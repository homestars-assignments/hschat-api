require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  self.use_instantiated_fixtures = true # Refer as local variables to all items in fixtures...

  setup do
    # Existing message
    @message = messages(:msg1)

    # New message to a user
    @new_pv_message = Message.new
    @new_pv_message.body = '🗣 Id habitant pulvinar tortor sociosqu sit massa aliquet malesuada sodales eleifend mi primis?'
    @new_pv_message.targetable = @nate
    @new_pv_message.user = @kimura

    # New messate to a channel
    @new_message = Message.new
    @new_message.body = '📢  Id habitant pulvinar tortor sociosqu sit massa aliquet malesuada sodales eleifend mi primis?'
    @new_message.targetable = @random
    @new_message.user = @kimura
  end

  test 'should get index' do
    get messages_url, as: :json
    assert_response :success
  end

  ##
  # Return a hash with values usable as parameter to the rest api.
  #
  # @param [Message] msg
  # @return [Hash] To be used as json params for http operations
  def message_params(msg)
    {
      message: {
        body: msg.body,
        user_id: msg.user_id,
        targetable_id: msg.targetable_id,
        targetable_type: msg.targetable_type
      }
    }
  end

  test 'should create message to user' do
    assert_difference('Message.count') do
      post messages_url, params: message_params(@new_pv_message), as: :json
    end

    assert_response 201
  end

  test 'should create message to channel' do
    assert_difference('Message.count') do
      post messages_url, params: message_params(@new_message), as: :json
    end

    assert_response 201
  end

  test 'should show message' do
    get message_url(@message), as: :json
    assert_response :success
  end

  test 'should update message' do
    patch message_url(@message), params: {message: {body: @message.body, user_id: @message.user_id}}, as: :json
    assert_response 200
  end

  test 'should destroy message' do
    assert_difference('Message.count', -1) do
      delete message_url(@message), as: :json
    end

    assert_response 204
  end
end
