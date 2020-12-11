require 'test_helper'

class CarTest < ActionDispatch::IntegrationTest
  setup do
    @text_file = fixture_file_upload('files/textfile.txt', 'txt')
    @image1 = fixture_file_upload('test_images/s13-1.jpg', 'image/jpeg')
    @image2 = fixture_file_upload('test_images/s13-2.jpg', 'image/jpeg')
    @image3 = fixture_file_upload('test_images/s13-3.jpg', 'image/jpeg')
    @image4 = fixture_file_upload('test_images/s13-4.jpg', 'image/jpeg')
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
    @comment = comments(:one)
    @user = users(:user_001)
    follow_redirect!
    assert_response :success
  end
  
   test "should save valid car" do

    #building a car with valid parameters
    @car = @user.cars.build(make: 'Nissan', model: 'Silvia S13', engine: 'SR20DET', transmission: 'Manual', description: 'The perfect drift car', images: [@image1, @image2, @image3, @image4])
    
    #testing if the built car is valid
    assert @car.valid?

    #testing the fields
    assert @car.make == 'Nissan'
    assert @car.model == 'Silvia S13'
    assert @car.engine == 'SR20DET'
    assert @car.transmission == 'Manual'
    assert @car.description == 'The perfect drift car'
    assert @car.user_id == @user.id
    assert @car.images.length == 4
  end

  test "should_not_save_invalid_car" do
    #building a car with invalid parameters (no model, no images)
    @car_no_make = @user.cars.build(model: 'Silvia S13', engine: 'SR20DET', transmission: 'Manual', description: 'The perfect drift car', images: [@image1, @image2, @image3, @image4])
    @car_no_model = @user.cars.build(make: 'Nissan', engine: 'SR20DET', transmission: 'Manual', description: 'The perfect drift car', images: [@image1, @image2, @image3, @image4])
    @car_no_engine = @user.cars.build(make: 'Nissan', model: 'Silvia S13', transmission: 'Manual', description: 'The perfect drift car', images: [@image1, @image2, @image3, @image4])
    @car_no_description = @user.cars.build(make: 'Nissan', model: 'Silvia S13', transmission: 'Manual', engine: 'SR20DET', images: [@image1, @image2, @image3, @image4])
    @car_no_transmission = @user.cars.build(make: 'Nissan', model: 'Silvia S13', engine: 'SR20DET', description: 'The perfect drift car', images: [@image1, @image2, @image3, @image4])
    @car_no_images = @user.cars.build(make: 'Nissan', model: 'Silvia S13', engine: 'SR20DET', transmission: 'Manual', description: 'The perfect drift car')
    
    #valid fields but with a text file in the list of images
    @car_wrong_image_file = @user.cars.build(make: 'Nissan', model: 'Silvia S13', engine: 'SR20DET', transmission: 'Manual', description: 'The perfect drift car', images: [@image1, @image2, @image3, @image4, @text_file])
    
    #testing if the built car is invalid
    assert_not @car_no_make.valid?
    assert_not @car_no_model.valid?
    assert_not @car_no_engine.valid?
    assert_not @car_no_description.valid?
    assert_not @car_no_transmission.valid?
    assert_not @car_no_images.valid?
    assert_not @car_wrong_image_file.valid?
  end
end
