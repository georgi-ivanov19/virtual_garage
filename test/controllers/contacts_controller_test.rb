require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get new_contact_url
    assert_response :success
  end

  test "should send contact email" do
    get new_contact_path
    post contacts_path, params: { contact: {
                name: "Test Contact",
                email: "test@example.com",
                message: "test message for the contact form"
    }}
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to root_path
  end
end
