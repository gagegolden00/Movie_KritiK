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
    fill_in "user_password", with: "asdfasdf"
    click_on "Submit"
  end

  def login_as_user 
    visit root_path
    fill_in "user_email", with: "user@user.com"
    fill_in "user_password", with: "asdfasdf"
    click_on "Submit"
  end
end
