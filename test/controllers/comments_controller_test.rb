require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
    @comment = comments(:one)
    @user = users(:user_001)
    @car = cars(:one)
    follow_redirect!
    assert_response :success
  end


  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to root_url
  end

  test "should destroy comments when user is destroyed" do
    assert_difference('Comment.count', -@user.comments.count) do
      @user.destroy 
    end
  end

  test "should destroy comments when car is destroyed" do
    assert_difference('Comment.count', -@car.comments.count) do
      @car.destroy 
    end
  end

end
