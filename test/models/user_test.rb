require 'test_helper'

class UserTest < ActionDispatch::IntegrationTest
  setup do
    @text_file = fixture_file_upload('files/textfile.txt', 'txt')
    @image1 = fixture_file_upload('test_images/s13-1.jpg', 'image/jpeg')
    @image2 = fixture_file_upload('test_images/s13-2.jpg', 'image/jpeg')
    @image3 = fixture_file_upload('test_images/s13-3.jpg', 'image/jpeg')
    @image4 = fixture_file_upload('test_images/s13-4.jpg', 'image/jpeg')
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
    @user = users(:user_001)
    follow_redirect!
    assert_response :success
  end

  # #building a car with valid parameters
  # @comment = @user.comments.build(content: "Test Comment", car_id: @car.id)

  # #building a comment with valid parameters
  # @car = @user.cars.build(make: 'Nissan', model: 'Silvia S13', engine: 'SR20DET', transmission: 'Manual', description: 'The perfect drift car', images: [@image1, @image2, @image3, @image4])

  test "should save valid user" do 
    @valid_user = User.new
    @valid_user.username = 'test_user'
    @valid_user.email = 'test@example.com'
    @valid_user.password = 'testing'

    @valid_user.save 
    assert @valid_user.valid? 
  end

  test "shouldn't save invalid user" do 
    @valid_user = User.new
    @valid_user.username = 'test_user'
    @valid_user.email = 'test@example.com'
    @valid_user.password = 'testing'
    @valid_user.save


    @user_no_username = User.new
    @user_no_username.username = ''
    @user_no_username.email = 'test@example.com'
    @user_no_username.password = 'testing'

    @user_no_email = User.new
    @user_no_email.username = 'test'
    @user_no_email.email = ''
    @user_no_email.password = 'testing'

    @user_invalid_email = User.new
    @user_invalid_email.username = 'test'
    @user_invalid_email.email = 'email.com'
    @user_invalid_email.password = 'testing'

    @user_no_password = User.new
    @user_no_password.username = 'test'
    @user_no_password.email = 'email@example.com'
    @user_no_password.password = ''

    @user_taken_email = User.new
    @user_taken_email.username = 'test'
    @user_taken_email.email = @valid_user.email
    @user_taken_email.password = 'asdasd'

    @user_taken_username = User.new
    @user_taken_username.username = @valid_user.username
    @user_taken_username.email = 'validemail@example.com'
    @user_taken_username.password = 'asdasd'

    assert_not @user_no_username.valid? 
    assert_not @user_no_email.valid?
    assert_not @user_invalid_email.valid? 
    assert_not @user_no_password.valid? 
    assert_not @user_taken_email.valid? 
    assert_not @user_taken_username.valid? 
  end

  test "should assign car and comment to user" do  
    @valid_user = User.new
    @valid_user.username = 'test_user'
    @valid_user.email = 'test@example.com'
    @valid_user.password = 'testing'
    @valid_user.save

    #building a car with valid parameters
    @car = @valid_user.cars.build(make: 'Nissan', model: 'Silvia S13', engine: 'SR20DET', transmission: 'Manual', description: 'The perfect drift car', images: [@image1, @image2, @image3, @image4])
    @car.save

    #building a comment with valid parameters   
    @comment = @valid_user.comments.build(content: "Test Comment", car_id: @car.id)
    @comment.save

    assert @valid_user.cars.count == 1
    assert @valid_user.comments.count == 1

  end

end
