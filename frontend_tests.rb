require 'watir-webdriver'
require 'minitest/autorun'
require File.dirname(__FILE__) + '/test_helper'

class FrontendTests < MiniTest::Unit::TestCase

  # Mixin the helper methods
  include HelperMethods


  def test_a_homepage_loads
    browser = open_browser

    puts "Load the frontend Team Kit Pro Site"
    browser.goto tkp_homepage_site_url

    # Check the text includes "Site Title"
    assert browser.text.include?("Site Title")

    # Close the browser
    browser.close
  end


  # Test signup flow


  def test_b_failed_login_fails
    browser = open_browser

    puts "Load the frontend Team Kit admin url"
    browser.goto tkp_admin_url

    # Check the text includes "Please Login" and that confirms we are redirected to the login page
    assert browser.text.include?("Please Login")

    # Do the failed login
    do_login("faileduser", "failpassword")

    # Check the text includes "Your Username / Password is wrong" and that confirms failed login
    assert browser.text.include?("Your Username / Password is wrong")

    # Close the browser
    browser.close
  end


  def test_c_login_passes
    browser = open_browser

    puts "Load the frontend Team Kit admin url"
    browser.goto tkp_admin_url

    # Check the text includes "Please Login" and that confirms we are redirected to the login page
    assert browser.text.include?("Please Login")

    # Do the login
    do_login("phawk", "jimbobuk")

    # Check the text includes "Welcome back Pete" and that confirms successful login
    assert browser.text.include?("Welcome back Pete")

    # Lets logout again
    do_logout

    # Close the browser
    browser.close
  end


  def test_d_add_a_new_user
    browser = open_browser

    puts "Load the frontend Team Kit admin url"
    browser.goto tkp_admin_url

    # Ensure user is logged in
    ensure_logged_in!

    # Lets go to the user admin page
    #browser.link(:text, "User Management").click
    browser.goto("#{tkp_admin_url()}/settings/users")

    # test the new user isn't already there
    assert !browser.text.include?("aj.user@test.com")

    # Lets go to the add user page
    browser.link(:text, "Add New User").click

    # Lets fill out the form
    browser.text_field(:name, "full_name").set("Andy John User")
    browser.text_field(:name, "display_name").set("AJ User")
    browser.text_field(:name, "username").set("ajuser")
    browser.text_field(:name, "email").set("aj.user@test.com")
    browser.text_field(:name, "password").set("testpass3")
    browser.text_field(:name, "conf_password").set("testpass3")

    # Submit the form
    browser.button(:value, "Add User").click

    # Check the user has been added now
    assert browser.text.include?("aj.user@test.com")

    # #TODO Let's delete the user

    # Lets logout again
    do_logout

    # Close the browser
    browser.close
  end


end # End of class TKP_frontend_tests