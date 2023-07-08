require 'test_helper'
require 'capybara/rails'

class NavTest < ActiveSupport::TestCase
  include Capybara::DSL

  setup do
    # Additional setup code if needed
  end

  teardown do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  test "logout link redirects to the logout action" do
    visit root_path

    # Click the logout link
    click_link "Logout"

    # Assert that the current path is the logout action path
    assert_equal destroy_user_session_path, current_path
  end
end
