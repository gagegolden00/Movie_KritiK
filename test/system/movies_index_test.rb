require "application_system_test_case"

class MoviesIndexTest < ApplicationSystemTestCase

  # movies index as an admin
  test "access movies as admin" do
    login_as_admin
    assert_equal movies_path, current_path
    within("#large-search-form") do
      assert_link('New Review')
      assert_selector('#genre-dropdown', visible: false )
      click_on "genre-button"
      sleep 1
      assert_selector('#genre-dropdown', visible: true)
      click_on "genre-button"
      sleep 1
    end
    within("#small-search-form", visible: :all) do
      assert_link('New Review', visible: :all)
    end
    assert_link('Edit')
    assert_link('Delete')
  end

  #movies index as a user
  test "access movies as user" do
    login_as_user
    assert_equal movies_path, current_path
    within("#large-search-form") do
      refute_link('New Review')
    end
    within("#small-search-form", visible: :all) do
      refute_link('New Review', visible: :all)
    end
    refute_link('Edit')
    refute_link('Delete')
  end

end
