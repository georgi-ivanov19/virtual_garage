require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
    @user = users(:user_001)
    @image1 = fixture_file_upload('test_images/s13-1.jpg', 'image/jpeg')
    @image2 = fixture_file_upload('test_images/s13-2.jpg', 'image/jpeg')
    @car = cars(:valid_car)
    @car.images = [@image1, @image2]
    follow_redirect!
    assert_response :success
  end

  test 'should get index' do
    get comments_url
    assert_template 'comments/index'
    assert_response :success
    assert_select 'title', 'Virtual Garage'
    assert_select 'h1', 'Comments'
    assert_template layout: "layouts/application", partial: "_headerout"
    assert_template layout: "layouts/application", partial: "_footer"
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete comment_url(comments(:one))
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
    assert_difference('Comment.count', -users(:user_001).comments.count) do
      users(:user_001).destroy
    end
  end

  test "should destroy comments when car is destroyed" do
    assert_difference('Comment.count', cars(:valid_car).comments.count) do
      cars(:valid_car).destroy
    end
  end

  #testing for when user signed out
  test "should not be able to post comment if signed out" do
    sign_out users(:user_001)
    post comments_url
    assert_redirected_to new_user_session_url
  end

  test "should not be able to delete comment if signed out" do
    sign_out users(:user_001)
    delete comment_url(comments(:one))
    assert_redirected_to new_user_session_url
  end

  #before creating @comment in the tests, it kept expecting -1,
  #so creating a comment and assigning it to the car makes sure
  #it does not go below 0, and responds as expected upon comment#delete
  test "should remove comment from car when comment deleted" do
    @comment = users(:user_001).comments.new(id: 777, content: 'Test comment', car_id: @car.id)
    @comment.save
    assert_difference('@car.comments.count', -1) do
      delete comment_url(@comment)
    end
  end

  test "should remove comment from user when comment deleted" do
    @comment = users(:user_001).comments.new(id: 777, content: 'Test comment', car_id: @car.id)
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
