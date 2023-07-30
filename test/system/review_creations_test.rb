require "application_system_test_case"

class ReviewCreationsTest < ApplicationSystemTestCase
  
  def setup 
    #genres = Genre.pluck[:name]
  end
  test "review creation process- access search as admin" do
    login_as_admin_and_start_review_creation
  end

  test "review creation process- display results as admin" do
    login_as_admin_and_start_review_creation
    sleep 1
    search_api_for_movies
    assert_selector "#search-results-1", visible: true
  end

  test "review creation process- visit a particular movie to review" do
    login_as_admin_and_start_review_creation
    sleep 1
    search_api_for_movies
    sleep 1
    select_a_searched_movie
  end

  test "review creation process- review creation failure with no field entries" do
    login_as_admin_and_start_review_creation
    sleep 1
    search_api_for_movies
    sleep 1
    select_a_searched_movie
    sleep 1
    assert_no_difference "Genre.count" do
      assert_no_difference "Movie.count" do
        assert_no_difference "Review.count" do
          click_button "Save"
          assert_text "The Following errors occured!"
          assert_text "Content can't be blank"
          assert_text "Score can't be blank"
          assert_text "Score is not a number"
        end
      end
    end
  end

  test "review creation process- review creation failure with no score field entry" do
    login_as_admin_and_start_review_creation
    sleep 1
    search_api_for_movies
    sleep 1
    select_a_searched_movie
    sleep 1
    assert_no_difference "Genre.count" do
      assert_no_difference "Movie.count" do
        assert_no_difference "Review.count" do
          fill_in "review_content", with: "Here is some content to go in the review text box"
          click_button "Save"
          assert_text "Score can't be blank"
          assert_text "Score is not a number"
        end
      end
    end
  end

  test "review creation process- review creation failure with no content field entry" do
    login_as_admin_and_start_review_creation
    sleep 1
    search_api_for_movies
    sleep 1
    select_a_searched_movie
    sleep 1
    assert_no_difference "Genre.count" do
      assert_no_difference "Movie.count" do
        assert_no_difference "Review.count" do
          fill_in "review_score", with: "10"
          click_button "Save"
          assert_text "Content can't be blank"
        end
      end
    end
  end

  #reconstruct the params hash and methodology / Params hash go in the setup

  test "review creation process- creation success" do
    login_as_admin_and_start_review_creation
    sleep 1
    search_api_for_movies
    sleep 1
    select_a_searched_movie
    sleep 1
    assert_no_difference "Genre.count" do
      assert_difference "Movie.count" do
        assert_difference "Review.count" do
          fill_in "review_score", with: "10"
          fill_in "review_content", with: "Here is some content to go in the review text box"
          click_button "Save"
          sleep 2
          assert_text "Review was successfully created"
          movie = Movie.last
          assert_equal "/movies/#{movie.id}", current_path
          assert_equal Movie.count == 6, Movie.count == 6
        end
      end
    end
  end



end
