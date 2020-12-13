require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
    @comment = comments(:one)
    @comment2 = comments(:two)
    @user = users(:user_001)
    @image1 = fixture_file_upload('test_images/s13-1.jpg', 'image/jpeg')
    @image2 = fixture_file_upload('test_images/s13-2.jpg', 'image/jpeg')
    @car = cars(:valid_car)
    @car.images = [@image1, @image2]
    follow_redirect!
    assert_response :success
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to root_url
  end

  test "should create comment" do
    assert_difference('Comment.count', 1) do
      post comments_url, params: {comment: {content: 'Test comment', user_id: @user.id, car_id: @car.id}}
    end
    assert_response :redirect
  end

  #testing the dependant: :destroy relation
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

  #testing for when user signed out
  test "should not be able to post comment if signed out" do
    sign_out @user
    post comments_url
    assert_redirected_to new_user_session_url
  end

  test "should not be able to delete comment if signed out" do
    sign_out @user
    delete comment_url(@comment)
    assert_redirected_to new_user_session_url
  end

  #before creating @comment in the tests, it kept expecting -1,
  #so creating a comment and assigning it to the car makes sure
  #it does not go below 0, and responds as expected upon comment#delete
  test "should remove comment from car when comment deleted" do
    @comment = @user.comments.new(id: 777, content: 'Test comment', car_id: @car.id)
    @comment.save
    assert_difference('@car.comments.count', -1) do
      delete comment_url(@comment)
    end
  end

  test "should remove comment from user when comment deleted" do
    @comment = @user.comments.new(id: 777, content: 'Test comment', car_id: @car.id)
    @comment.save
    assert_difference('@user.comments.count', -1) do
      delete comment_url(@comment)
    end
  end

  test "should assign comment to car upon creating valid comment" do
    assert_difference('@car.comments.count', 1) do
      post comments_url, params: {comment: {content: 'Test comment', user_id: @user.id, car_id: @car.id}}
    end
  end

  test "should assign comment to user upon creating valid comment" do
    assert_difference('@user.comments.count', 1) do
      post comments_url, params: {comment: {content: 'Test comment', user_id: @user.id, car_id: @car.id}}
    end
  end
  
end
