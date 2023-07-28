require "application_system_test_case"

class LoginSignupsTest < ApplicationSystemTestCase
  test "Sign Up from root path / home" do
    visit root_path
    sleep 0.5
    click_on "signup"
    sleep 0.5
    fill_in "user_first_name", with: "test firstname"
    sleep 0.5
    fill_in "user_last_name", with: "test lastname"
    sleep 0.5
    fill_in "user_username", with: "test username"
    sleep 0.5
    fill_in "user_email", with: "minitest@example.com"
    sleep 0.5
    fill_in "user_password", with: "asdfasdf"
    sleep 0.5
    fill_in "user_password_confirmation", with: "asdfasdf"
    sleep 0.5
    click_on "Create an Account"
    sleep 0.5

    # verify user created successfully
    assert_equal movies_path, movies_path
  end

  test "from root path to sign up back to root path" do 
    visit root_path
    click_on "signup"
    sleep 0.5
    click_on "signin"
    assert_equal root_path, root_path
  end
end
