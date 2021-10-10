require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:castello)

    @new_user = User.new
    @new_user.name = 'Grady_Booch'
    @new_user.email = 'Grady.Booch@email.com'
    @new_user.bio = 'scientist, storyteller, philosopher'
    @new_user.password_digest = '$2a$12$MYv41dkc0J.6Sj4jASCS/.4ojHf/9Im97DBaX3jmZiDfz4jq75Q4m'
  end

  test 'should get index' do
    get users_url, headers: auth, as: :json
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      info =
        {
          bio: @new_user.bio,
          email: @new_user.email,
          name: @new_user.name,
          username: @new_user.username,
          password: '123456'
        }
      post users_url, headers: auth, params: info, as: :json
    end

    assert_response 201
  end

  test 'should show user' do
    get user_url(@user), headers: auth, as: :json
    assert_response :success
  end
end
