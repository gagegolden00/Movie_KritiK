require "application_system_test_case"

class ReviewCreationsTest < ApplicationSystemTestCase


    test "review creation process- access search as admin" do
        login_as_admin_and_start_review_creation
    end

    test "review creation process- display results as admin" do 
        login_as_admin_and_start_review_creation
        search_api_for_movies
        assert_selector "#search-results-1", visible: true
    end

    test "review creation process- visit a particular movie to review" do
        login_as_admin_and_start_review_creation
        search_api_for_movies
        select_a_searched_movie
    end

    test "review creation process- review creation failure with no field entries" do
        login_as_admin_and_start_review_creation
        search_api_for_movies
        select_a_searched_movie
        assert_no_difference 'Review.count' do
            click_button "Save"
            assert_text "The Following errors occured!"
            assert_text "Content can't be blank"
            assert_text "Score can't be blank"
            assert_text "Score is not a number"
        end
    end

    test "review creation process- review creation failure with no score field entry" do
        login_as_admin_and_start_review_creation
        search_api_for_movies
        select_a_searched_movie
        assert_no_difference 'Review.count' do
            fill_in "review_content", with: "Here is some content to go in the review text box"
            click_button "Save"
            assert_text "Score can't be blank"
            assert_text "Score is not a number"
        end
    end

    test "review creation process- review creation failure with no content field entry" do
        login_as_admin_and_start_review_creation
        search_api_for_movies
        select_a_searched_movie
        assert_no_difference 'Review.count' do
            fill_in "review_score", with: "10"
            click_button "Save"
            assert_text "Content can't be blank"
        end
    end

    #reconstruct the params hash and methodology / Params hash go in the setup 

    test "review creation process- genre creation success" do

    end
    test "review creation process- movie creation success" do

    end
    test "review creation process- review creation success" do

    end
    test "review creation process- " do

    end
    test "review creation process- " do

    end
    test "review creation process- " do

    end
    test "review creation process- " do

    end
    test "review creation process- " do

    end
    test "review creation process- " do

    end

end
