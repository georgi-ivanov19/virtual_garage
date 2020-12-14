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
