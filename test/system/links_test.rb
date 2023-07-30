require "application_system_test_case"
require "rack_session_access/capybara"

class LinksTest < ApplicationSystemTestCase

  test "navigation testing - logo / link to root path " do 
    login_as_admin_to_reviews_search_path
    click_link "movies-index-link-logo"
    assert_equal movies_path, current_path
  end

  test "navigation testing - movie reviews link " do
    login_as_admin_to_reviews_search_path
    click_link "movies-index-link"
    assert_equal movies_path, current_path
  end

  test "navigation testing - new review link " do
    login_as_admin 
    click_link "new-review-link"
    assert_equal reviews_search_reviews_path, current_path
  end

  test "navigation testing - account link" do 
    login_as_admin
    dropdown = find('#dropdown')
    dropdown.hover
    click_link "account-link"
    assert_equal "/account", current_path
  end

  test "navigation testing - logout link" do
    login_as_admin
    dropdown = find('#dropdown')
    dropdown.hover
    click_link "logout-link"
    assert_equal "/", current_path
    assert_equal false, get_session_bool
  end


end
