<<<<<<< HEAD
require 'test_helper'
require "application_system_test_case"

class CarTest < ActionDispatch::IntegrationTest
  setup do
    @text_file = fixture_file_upload('files/textfile.txt', 'txt')
    @image1 = fixture_file_upload('test_images/s13-1.jpg', 'image/jpeg')
    @image2 = fixture_file_upload('test_images/s13-2.jpg', 'image/jpeg')
    @image3 = fixture_file_upload('test_images/s13-3.jpg', 'image/jpeg')
    @image4 = fixture_file_upload('test_images/s13-4.jpg', 'image/jpeg')
    get '/users/sign_in'
    #valid fixtures
    cars(:valid_car).images = [@image1, @image2, @image3, @image4]
    cars(:valid_car2).images = [@image1, @image2, @image3, @image4]
    sign_in users(:user_001)
    post user_session_url
    follow_redirect!
    assert_response :success
  end

   test "should save valid car" do
    assert cars(:valid_car).valid?
    assert cars(:valid_car2).valid?

    #testing the fields
    assert cars(:valid_car).make == 'Nissan'
    assert cars(:valid_car).model == 'Silvia S13'
    assert cars(:valid_car).engine == 'SR20DET'
    assert cars(:valid_car).transmission == 'Manual'
    assert cars(:valid_car).description == 'The perfect drift car'
    assert cars(:valid_car).user_id == users(:user_001).id
    assert cars(:valid_car).images.length == 4
  end

  test "should_not_save_invalid_car" do
    @car = Car.new
    assert_not @car.valid?
    @car.make = 'Nissan'
    @car.model = 'Supra'
    @car.engine = '2JZ'
    @car.transmission = 'automatic'
    @car.description = 'invalid car'
    assert_not @car.valid?
    @car.make = ''
    @car.model = ''
    @car.engine = ''
    @car.transmission = ''
    @car.description = ''
    assert_not @car.valid?
    @car.make='aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    @car.model='aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    @car.engine='aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    @car.transmission='aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    assert_not @car.valid?
  end


end
=======
require 'test_helper'

class CarTest < ActionDispatch::IntegrationTest
  setup do
    @text_file = fixture_file_upload('files/textfile.txt', 'txt')
    @image1 = fixture_file_upload('test_images/s13-1.jpg', 'image/jpeg')
    @image2 = fixture_file_upload('test_images/s13-2.jpg', 'image/jpeg')
    @image3 = fixture_file_upload('test_images/s13-3.jpg', 'image/jpeg')
    @image4 = fixture_file_upload('test_images/s13-4.jpg', 'image/jpeg')
    get '/users/sign_in'
    @valid_car = cars(:valid_car)                         #valid fixture
    @valid_car2 = cars(:valid_car2)
    @missing_brand = cars(:missing_brand)                 #fixture with a missing brand
    @missing_model = cars(:missing_model)                 #fixture with a missing model
    @missing_engine = cars(:missing_engine)               #fixture with a missing engine
    @missing_transmission = cars(:missing_transmission)   #fixture with a missing transmission
    @missing_description = cars(:missing_description)     #fixture with a missing description
    @missing_images = cars(:missing_images)               #fixture with missing images
    @wrong_image_file = cars(:wrong_image_file)           #fixture with a text file in images
    @valid_car.images = [@image1, @image2, @image3, @image4]
    @valid_car2.images = [@image1, @image2, @image3, @image4]
    @missing_brand.images = [@image1, @image2, @image3, @image4]
    @missing_model.images = [@image1, @image2, @image3, @image4]
    @missing_engine.images = [@image1, @image2, @image3, @image4]
    @missing_transmission.images = [@image1, @image2, @image3, @image4]
    @missing_description.images = [@image1, @image2, @image3, @image4]
    @wrong_image_file.images = [@image1, @image2, @image3, @image4, @text_file]
    sign_in users(:user_001)
    post user_session_url
    @comment = comments(:one)
    @user = users(:user_001)
    follow_redirect!
    assert_response :success
  end

   test "should save valid car" do
    assert @valid_car.valid?
    assert @valid_car2.valid?

    #testing the fields
    assert @valid_car.make == 'Nissan'
    assert @valid_car.model == 'Silvia S13'
    assert @valid_car.engine == 'SR20DET'
    assert @valid_car.transmission == 'Manual'
    assert @valid_car.description == 'The perfect drift car'
    assert @valid_car.user_id == @user.id
    assert @valid_car.images.length == 4
  end

  test "should_not_save_invalid_car" do

    #testing if the built car is invalid
    assert_not @missing_brand.valid?
    assert_not @missing_model.valid?
    assert_not @missing_engine.valid?
    assert_not @missing_description.valid?
    assert_not @missing_transmission.valid?
    assert_not @missing_images.valid?
    assert_not @wrong_image_file.valid?
  end

end
>>>>>>> 8e7df3715d29d641d54c31fe62dfdcbea066054c
