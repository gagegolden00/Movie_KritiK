ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new, Minitest::Reporters::HtmlReporter.new]   
# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new     # => Turn-like output that reads like a spec
# Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new  # => Redgreen-capable version of standard Minitest reporter
# Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new # => Fuubar-like output with a progress bar
# Minitest::Reporters.use! Minitest::Reporters::RubyMateReporter.new # => Simple reporter designed for RubyMate
# Minitest::Reporters.use! Minitest::Reporters::RubyMineReporter.new # => Reporter designed for RubyMine IDE and TeamCity CI server
# Minitest::Reporters.use! Minitest::Reporters::JUnitReporter.new    # => JUnit test reporter designed for JetBrains TeamCity
# Minitest::Reporters.use! Minitest::Reporters::MeanTimeReporter.new # => Produces a report summary showing the slowest running tests
# Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new     # => Generates an HTML report of the test results

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def login_as_admin
    visit root_path
    fill_in "user_email", with: "admin@admin.com"
    sleep 1
    fill_in "user_password", with: "asdfasdf"
    sleep 1
    click_on "Submit"
    #@user_admin = users(:user_admin)
  end

  def login_as_user 
    visit root_path
    fill_in "user_email", with: "user@user.com"
    sleep 1
    fill_in "user_password", with: "asdfasdf"
    sleep 1
    click_on "Submit"
    #@user_regular = users(:user_regular)
  end

  def login_as_admin_and_start_review_creation
    login_as_admin
    sleep 1
    visit "/movies/reviews/search"
  end

  def search_api_for_movies
    refute_selector "#search-results-1", visible: false
    sleep 1
    fill_in "review_title", with: "star wars"
    sleep 1
    click_button "Search"
    sleep 1
  end

  def select_a_searched_movie
    within("#search-results-1") do
      click_link ("Review")
    end
    sleep 2
  assert_equal new_review_path, current_path
  end

  def login_as_admin_to_reviews_search_path
    login_as_admin
    visit reviews_search_reviews_path
    assert_equal reviews_search_reviews_path, current_path
  end

  def get_session_bool
    warden_auth_hash = page.get_rack_session
    user_key = warden_auth_hash['warden.user.user.key']
    user_key.present? ? true : false
  end

end
