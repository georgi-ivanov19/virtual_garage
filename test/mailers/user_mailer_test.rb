require 'test_helper'


class UserMailerTest < ActionMailer::TestCase

  #Mailer preview at: http://localhost:3000/rails/mailers/user_mailer/notify_user
  def test_welcome_email
    user = users(:user_001)

    # Send the email, then test that it got queued
    email = UserMailer.notify_user(user).deliver
    assert !ActionMailer::Base.deliveries.empty?

    #Check if the headers and content of the sent email contains what we expect it to
    assert_equal email.from, ['virtualgaragee1@gmail.com']
    assert_equal [user.email], email.to
    assert_equal "Virtual Garage Sign up Confirmation", email.subject
    assert_select_email do
      #verifying email body content
      assert_select "#email-title", "Welcome to Virtual Garage, #{user.username}!"
      assert_select '.email', {:count => 5}
      assert_select ('.email') do
        assert_select 'span', 3
        assert_select 'p', 2
      end
      assert_select "#signature", "-The Virtual Garage team"
      assert_select "#faqs", "FAQs"
      assert_select "#contact", "Contact us"
      assert_select "#vg2020", "© Virtual Garage #{Time.now.year}"
    end
  end

  def test_user_update_email
    user = users(:user_001)

    email = UserMailer.user_edited(user).deliver
    assert !ActionMailer::Base.deliveries.empty?

    #Check if the headers and content of the sent email contains what we expect it to
    assert_equal email.from, ['virtualgaragee1@gmail.com']
    assert_equal [user.email], email.to
    assert_equal "Your Virtual Garage password has been changed", email.subject
    assert_select_email do
      #verifying email body content
      assert_select "#email-title", "Hello #{user.username},"
      assert_select '.email', {:count => 4}
      assert_select ('.email') do
        assert_select 'span', 2
        assert_select 'p', 2
      end
      assert_select "#signature", "-The Virtual Garage team"
      assert_select "#faqs", "FAQs"
      assert_select "#contact", "Contact us"
      assert_select "#vg2020", "© Virtual Garage #{Time.now.year}"
    end
  end

  def test_account_deleted_email
    user = users(:user_001)

    email = UserMailer.account_deleted(user).deliver
    assert !ActionMailer::Base.deliveries.empty?

    #Check if the headers and content of the sent email contains what we expect it to
    assert_equal email.from, ['virtualgaragee1@gmail.com']
    assert_equal [user.email], email.to
    assert_equal "Your Virtual Garage account has been cancelled", email.subject
    assert_select_email do
      #verifying email body content
      assert_select "#email-title", "Hello #{user.username},"
      assert_select '.email', {:count => 4}
      assert_select ('.email') do
        assert_select 'span', 2
        assert_select 'p', 2
      end
      assert_select "#signature", "-The Virtual Garage team"
      assert_select "#faqs", "FAQs"
      assert_select "#contact", "Contact us"
      assert_select "#vg2020", "© Virtual Garage #{Time.now.year}"
    end
  end
  #Short test for ActionMailer environment settings
  test 'should get correct mailer settings' do
    assert_equal ActionMailer::Base.delivery_method, :test
    assert_equal ActionMailer::Base.default_url_options, { host: 'localhost', port: 3000 }
    assert_equal ActionMailer::Base.perform_caching, false
  end
end
