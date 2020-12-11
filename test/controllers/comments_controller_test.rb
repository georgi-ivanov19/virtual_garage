require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
    @comment = comments(:one)

    follow_redirect!
    assert_response :success
  end

  # test "should get index" do
  #   get comments_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_comment_url
  #   assert_response :success
  # end


  # test "should show comment" do
  #   get comment_url(@comment)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_comment_url(@comment)
  #   assert_response :success
  # end

  # test "should update comment" do
  #   patch comment_url(@comment), params: { comment: { content: @comment.content } }
  #   assert_response :success
  # end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to comments_url
  end
end
