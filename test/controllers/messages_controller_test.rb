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

    # New message to a channel
    @new_message = Message.new
    @new_message.body = '📢  Id habitant pulvinar tortor sociosqu sit massa aliquet malesuada sodales eleifend mi primis?'
    @new_message.targetable = @random
    @new_message.user = @kimura
  end

  def parent_channel
    { 'channel_id': @announcements.id }
  end

  test 'should get index' do
    get channel_messages_url(@announcements), params: parent_channel, headers: auth, as: :json
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

  test 'should create message to channel' do
    assert_difference('Message.count') do
      post channel_messages_url(@announcements),
           params: parent_channel.merge({ 'body': @new_message.body }),
           headers: auth, as: :json
    end

    assert_response 201
  end

  test 'should show message' do
    get message_url(@message), headers: auth, as: :json
    assert_response :success
  end

  test 'should update message' do
    patch message_url(@message), params: { message: { body: @message.body, user_id: @message.user_id } }, headers: auth, as: :json
    assert_response 200
  end
end
