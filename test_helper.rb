$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

module HelperMethods

  def open_browser
    puts "Open a browser (chrome)"
    @browser = Watir::Browser.new :chrome
    return @browser
  end

  def tkp_admin_url
    "http://frontend.example.com/admin"
  end

  def tkp_homepage_site_url
    "http://frontend.example.com"
  end

  def is_logged_in?
    @browser.text.include?("Account Settings")
  end

  def ensure_logged_in!
    if is_logged_in?
      return true
    else
      self.do_login("phawk", "BLEHHHHH")
    end
  end

  def do_login(user, pass)
    # Enter the correct login details
    puts "Fill in the login details"
    @browser.text_field(:name, "username").set(user)
    @browser.text_field(:name, "password").set(pass)

    # Click the login button
    puts "Click the login button"
    @browser.button(:value, "Login").click

    # Check the text includes "Welcome back " and that confirms successful login
    assert @browser.text.include?("Welcome back ")
  end

  def do_logout
    puts "Logout user"
    @browser.link(:text, "Logout").click

    # Check the text includes "Teamkit Pro" and that confirms we have logged out
    assert @browser.text.include?("Teamkit Pro")
  end
end