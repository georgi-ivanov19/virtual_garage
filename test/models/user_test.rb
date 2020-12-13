require 'test_helper'

class UserTest < ActionDispatch::IntegrationTest
  setup do
    @image1 = fixture_file_upload('test_images/s13-1.jpg', 'image/jpeg')
    @image2 = fixture_file_upload('test_images/s13-2.jpg', 'image/jpeg')
    @image3 = fixture_file_upload('test_images/s13-3.jpg', 'image/jpeg')
    @image4 = fixture_file_upload('test_images/s13-4.jpg', 'image/jpeg')
    get '/users/sign_in'
    @car = cars(:valid_car)
    @car.images = [@image1]
    sign_in users(:user_001)
    post user_session_url
    follow_redirect!
    assert_response :success
  end

  test "should save valid user" do
    assert users(:user_001).valid?
  end

  test "shouldn't save invalid user" do
    #creating all the possible invalid users and checking that they do not save

    assert_not users(:no_username).valid?
    assert_not users(:long_username).valid?
    assert_not users(:no_password).valid?
    assert_not users(:invalid_email).valid?
    assert_not users(:no_password).valid?
  end

  test "should assign cars to user" do
    assert_equal users(:user_001).cars.count, Car.all.where(:user_id == users(:user_001).id).count
  end

  test "should assign comments to user" do
    assert_equal users(:user_001).comments.count, Comment.all.where(:user_id == users(:user_001).id).count
  end
end
