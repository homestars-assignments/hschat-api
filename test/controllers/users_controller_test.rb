require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:castello)

    @new_user = User.new
    @new_user.name = 'Grady_Booch'
    @new_user.email = 'Grady.Booch@email.com'
    @new_user.bio = 'scientist, storyteller, philosopher'
  end

  test 'should get index' do
    get users_url, as: :json
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url, params: { user: { bio: @new_user.bio, email: @new_user.email, name: @new_user.name } }, as: :json
    end

    assert_response 201
  end

  test 'should show user' do
    get user_url(@user), as: :json
    assert_response :success
  end

  test 'should update user' do
    patch user_url(@user), params: { user: { bio: @user.bio, email: @user.email, name: @user.name } }, as: :json
    assert_response 200
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete user_url(@user), as: :json
    end

    assert_response 204
  end
end
