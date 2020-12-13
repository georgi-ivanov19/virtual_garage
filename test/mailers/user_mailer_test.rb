require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  #Mailer preview at: http://localhost:3000/rails/mailers/user_mailer/notify_user
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

  test 'should get correct mailer settings' do
    assert_equal ActionMailer::Base.delivery_method, :test
    assert_equal ActionMailer::Base.default_url_options, { host: 'localhost', port: 3000 }
    assert_equal ActionMailer::Base.perform_caching, false
  end
end
