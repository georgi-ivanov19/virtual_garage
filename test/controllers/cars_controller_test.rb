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
    assert_template 'cars/index'
    assert_response :success
    assert_select 'title', 'Virtual Garage'
    #there should be as many captions as cars
    assert_select '.caption',{count: Car.all.count}
    assert_template layout: "layouts/application", partial: "_headerout"
    assert_template layout: "layouts/application", partial: "_footer"
  end

  test "should get new" do
    get new_car_url
    assert_template 'cars/new'
    assert_response :success
    assert_select "form", true, 'Page must contain a form'
    assert_select 'h2', 'Add a new car to your garage'

    #every input has a name
    assert_select "form input" do
      assert_select ":match('name', ?)", /.+/  # Not empty
    end
    #3 hidden + 7 visible
    assert_select "form input", 10

    #car form inputs and labels
    assert_select 'label',{count: 6}
    assert_select "#car_make", true
    assert_select "#car_model", true
    assert_select "#car_engine", true
    assert_select "#car_transmission", true
    assert_select "#car_description", true
    assert_select "#car_images", true
    assert_template layout: "layouts/application", partial: "_headerout"
    assert_template layout: "layouts/application", partial: "_footer"
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
    @user = User.create(
      username: 'asdasd',
      email: 'asd13@asd.asd',
      encrypted_password: 'asdasd')
    get garage_url(@user.username)
    assert_response :found

  end

  test "should get FAQs" do
    get faqs_url
    assert_template 'cars/FAQs'
    assert_select "h2", "Virtual Garage FAQs"
    assert_select ".question",{count: 4}
    assert_select ".answer",{count: 4}
    assert_template layout: 'layouts/application', partial: "_headerout"
    assert_template layout: "layouts/application", partial: "_footer"
    assert_response :success
  end

  test "should show car" do
    get car_url(@car)
    assert_template 'cars/show'
    assert_response :success
    assert_select "form", true, 'Page must contain a form'
    assert_select '.show-img-small',{count: @car.images.count}
    assert_select '#show-img',{count: 1}
    assert_select '#comment_car_id' #hidden field
    assert_select "h2", 'Comments'
    #if no @car.comments the one <p> to indicate empty comment sections, else as many <p>s as @car.comments.count
    if @car.comments.count == 0
      assert_select '.comment-section-wrapper p',{count: 1}
    else
      assert_select '.comment-section-wrapper p',{count: @car.comments.count}
    end
    assert_template layout: "layouts/application", partial: "_headerout"
    assert_template layout: "layouts/application", partial: "_footer"
  end

  test "should get edit" do
    get edit_car_url(@car)
    assert_template 'cars/edit'
    assert_response :success
    assert_select "form", true, 'Page must contain a form'
    assert_select 'h2', "Edit your #{@car.make} #{@car.model}"
    assert_select 'h6', 'DISCLAIMER! your old car photos will be replaced with the new ones'


    assert_select 'label',{count: 6}
    assert_select "#car_make"
    assert_select "#car_model"
    assert_select "#car_engine"
    assert_select "#car_transmission"
    assert_select "#car_description"
    assert_select "#car_images"

    assert_template layout: "layouts/application", partial: "_headerout"
    assert_template layout: "layouts/application", partial: "_footer"
  end

  test "should update car" do
    patch car_url(@car), params: { car: { description: @car.description, engine: @car.engine, make: @car.make, model: @car.model, transmission: @car.transmission } }
    assert_response :success

    assert_template layout: "layouts/application", partial: "_headerout"
    assert_template layout: "layouts/application", partial: "_footer"
  end

  test "should destroy car" do
    assert_difference('Car.count', -1) do
      delete car_url(@car)
    end

    assert_redirected_to cars_url
  end

  test "should destroy cars when user is destroyed" do
    assert_difference('Car.count', -@user.cars.count) do
      @user.destroy
    end
  end
end