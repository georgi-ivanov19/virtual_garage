require 'test_helper'

class CarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
    @image1 = fixture_file_upload('test_images/s13-1.jpg', 'image/jpeg')
    @image2 = fixture_file_upload('test_images/s13-2.jpg', 'image/jpeg')
    @car = cars(:valid_car)
    @car.images = [@image1, @image2]
    @comment = comments(:one)
    @user = users(:user_001)
    follow_redirect!
    assert_response :success
  end

  test "should not get car#new if signed out" do
    sign_out @user
    get new_car_url
    assert_redirected_to new_user_session_url
  end

  test "should not get car#edit if signed out" do
    sign_out @user
    get edit_car_url(@car)
    assert_redirected_to new_user_session_url
  end

  test "should get index" do
    get cars_url
    assert_response :success
    assert_select 'title', 'Virtual Garage'
  end

  test "should get new" do
    get new_car_url
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { content: @comment.content, car_id: @car.id, user_id: @user.id} }
    end

    assert_redirected_to root_path
  end

  test "should create car" do
    assert_difference('Car.count') do
      post cars_url, params: { car: { description: @car.description, engine: @car.engine, make: @car.make, model: @car.model, transmission: @car.transmission, user_id: @user.id, images: [@image1, @image2]}}
    end

    assert_redirected_to car_url(Car.last)
  end

  test "should get garage" do
    get garage_url(@user)
    assert_response :found
  end

  test "should get FAQs" do
    get faqs_url
    assert_response :success
  end

  test "should show car" do
    get car_url(@car)
    assert_response :success
  end

  test "should get edit" do
    get edit_car_url(@car)
    assert_response :success
  end

  test "should update car" do
    patch car_url(@car), params: { car: { description: @car.description, engine: @car.engine, make: @car.make, model: @car.model, transmission: @car.transmission } }
    assert_response :success
  end

  test "should destroy car" do
    assert_difference('Car.count', -1) do
      delete car_url(@car)
    end

    assert_redirected_to cars_url
  end

  test "should destroy car when user is destroyed" do
    assert_difference('Car.count', -@user.cars.count) do
      @user.destroy
    end
  end

end
