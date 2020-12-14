require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get new_contact_url
    assert_template 'contacts/new'
    assert_response :success


    assert_template layout: "layouts/application", partial: "_headerin"
    assert_template layout: "layouts/application", partial: "_footer"
    end


  test "should send contact email" do
    get new_contact_path
    post contacts_path, params: { contact: {
                name: "Test Contact",
                email: "test@example.com",
                message: "test message for the contact form"
    }}
    @email = ActionMailer::Base.deliveries.last
    #from: in contact.rb defined as from: %("#{name}" <#{email}>)
    assert_equal 'Test Contact <test@example.com>', @email['from'].to_s
    assert_equal 'Virtual Garage Contact Form', @email['subject'].to_s
    assert_equal 'virtualgaragee1@gmail.com', @email['to'].to_s
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to root_path

  end

  test "should get correct email contents" do
    get new_contact_path
    post contacts_path, params: { contact: {
                name: "Test Contact",
                email: "test@example.com",
                message: "test message for the contact form"
    }}
    @email = ActionMailer::Base.deliveries.last
    #from: in contact.rb defined as from: %("#{name}" <#{email}>)
    assert_equal 'Test Contact <test@example.com>', @email['from'].to_s
    assert_equal 'Virtual Garage Contact Form', @email['subject'].to_s
    assert_equal 'virtualgaragee1@gmail.com', @email['to'].to_s
  end

  test 'should get correct mailer settings' do
    assert_equal ActionMailer::Base.delivery_method, :test
    assert_equal ActionMailer::Base.default_url_options, { host: 'localhost', port: 3000 }
    assert_equal ActionMailer::Base.perform_caching, false
  end


end
