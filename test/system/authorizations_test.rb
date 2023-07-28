require "application_system_test_case"

class AuthorizationsTest < ApplicationSystemTestCase

  test "deny user access to movies/reviews/new" do
    login_as_user
    visit "/movies/reviews/new"
    assert_equal movies_path, current_path
    assert_text "Sorry you dont have the proper permissions to perform this action"
  end

  test "deny user access to movies/reviews/search" do
    login_as_user
    visit "/movies/reviews/search"
    assert_equal movies_path, current_path
    assert_text "Sorry you dont have the proper permissions to perform this action"
  end

  test "deny user access to movies/reviews/id/edit" do
    login_as_user
    # if test fails make sure the ID exists
    visit "/movies/reviews/1/edit"
    assert_equal movies_path, current_path
    assert_text "Sorry you dont have the proper permissions to perform this action"
  end
end
