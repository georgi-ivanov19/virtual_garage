require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def test_welcome_email
    user = users(:user_001)

    # Send the email, then test that it got queued
    email = UserMailer.notify_user(user).deliver
    assert !ActionMailer::Base.deliveries.empty?


    # Test the headers of the sent email contains what we expect it to
    assert_equal email.from, ['virtualgaragee1@gmail.com']
    assert_equal [user.email], email.to
    assert_equal "Virtual Garage Sign up Confirmation", email.subject
  end
end
