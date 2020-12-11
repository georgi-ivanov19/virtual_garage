require 'test_helper'

class CommentTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
    @car = cars(:one)
    @user = users(:user_001)
    follow_redirect!
    assert_response :success
  end
  
  test "should save valid comment" do
    @comment = @user.comments.build(content: "Test Comment", car_id: @car.id)
    assert @comment.content == "Test Comment"
    assert @comment.user_id == @user.id
    assert @car.comments
  end

  test "shouldn't save invalid comment" do
    @comment_no_content = @user.comments.build(content: "", car_id: @car.id)
    assert_not @comment_no_content.valid?
  end

end
