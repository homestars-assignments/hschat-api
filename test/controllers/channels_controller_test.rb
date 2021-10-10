require 'test_helper'

class ChannelsControllerTest < ActionDispatch::IntegrationTest
    self.use_instantiated_fixtures = true # Refer as local variables to all items in fixtures...

  setup do
    @channel = @announcements
  end

  test 'should get index' do
    get channels_url, headers: auth, as: :json
    assert_response :success
  end

  test 'should create channel' do
    assert_difference('Channel.count') do
      name = 'frontend'
      description = 'html, css, js, design, and other fun user-facing stuff'

      post channels_url, params: {channel: {description: description, name: name}}, headers: auth, as: :json
    end

    assert_response 201
  end

  test 'should show channel' do
    get channel_url(@channel), headers: auth, as: :json
    assert_response :success
  end

  test 'should update channel' do
    patch channel_url(@channel),
          params: {channel: {description: @channel.description, name: @channel.name}},
          headers: auth, as: :json
    assert_response 200
  end

  test 'should destroy channel' do
    assert_difference('Channel.count', -1) do
      delete channel_url(@channel), headers: auth, as: :json
    end

    assert_response 204
  end
end
