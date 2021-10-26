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

  test 'should return unauthorized without token' do
    get channels_url, as: :json
    assert_response :unauthorized
  end

  test 'should list only matched joined channels' do
    get channels_url + '?joined=true', headers: auth, as: :json
    channels = @response.parsed_body
    assert_equal channels.length, 2 # <-- user.channels.length
    # user.channels.each  do |channel| channels.included?(channel) end
    assert_equal channels[0]['name'], 'Announcements'
    assert_equal channels[1]['name'], 'Coding'
  end

  # TODO: Write tests for
  # - Get the index withouth auth.
  # - Get the index with variants for the joined parameter (true/false), also with wrong values.
  # - Performance:
  #   - ...
  # - 2 differents users asking for their joined channels.
  # - ...

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
