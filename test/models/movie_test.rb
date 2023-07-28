# test/models/movie_test.rb
require "test_helper"

class MovieTest < ActiveSupport::TestCase

  fixtures :movies, :genres, :movie_genres, :reviews

  ## SEARCH BY TERM TESTS ##
  test "search_by_term returns movies matching the search term in title" do
    assert_includes Movie.search_by_term("Avatar".downcase), movies(:avatar)
    refute_includes Movie.search_by_term("Avatar".downcase), movies(:black_clover, :constantine, :indiana_jones, :shameless)
  end
  
  test "search_by_term returns movies matching the search term in actors" do
    assert_includes Movie.search_by_term("Emmy"), movies(:shameless)
    assert_includes Movie.search_by_term("Emmy Rossum"), movies(:shameless)
    refute_includes Movie.search_by_term("Emmy"), movies(:indiana_jones, :avatar, :constantine, :black_clover)
  end
  
  test "search_by_term returns movies matching the search term in director" do
    assert_includes Movie.search_by_term("Francis".downcase), movies(:constantine)
    assert_includes Movie.search_by_term("Francis Lawrence".downcase), movies(:constantine)
    refute_includes Movie.search_by_term("Francis Lawrence".downcase), movies(:black_clover, :shameless, :indiana_jones, :avatar)
  end

  test "search_by_term is case-insensitive" do
    # Ensure the search term is case-insensitive by downcasing it.
    assert_includes Movie.search_by_term("CoNsTaNtInE".downcase), movies(:constantine)
    refute_includes Movie.search_by_term("CoNsTaNtInE".downcase), movies(:black_clover, :shameless, :indiana_jones, :avatar)
  end

  ## SEARCH BY RATING TESTS ##

  test "search_by_rating returns movies matching the search rating" do

    assert_includes Movie.search_by_rating("PG"), movies(:indiana_jones)
    refute_includes Movie.search_by_rating("PG"), movies(:black_clover, :shameless, :constantine, :avatar)
    assert_includes Movie.search_by_rating("PG-13"), movies(:avatar)
    refute_includes Movie.search_by_rating("PG-13"), movies(:black_clover, :shameless, :constantine, :indiana_jones)


  end

  ## SEARCH BY GENRE TESTS ##

  test "search_by_genre_tests" do
    assert_includes Movie.search_by_genre("Action"), movies(:avatar), movies(:black_clover)
    assert_includes Movie.search_by_genre("Action"), movies(:constantine), movies(:indiana_jones)
    refute_includes Movie.search_by_genre("Action"), movies(:shameless)
    assert_not_empty Movie.search_by_genre("Action")

  end

  ## SEARCH BY YEAR TESTS ##

  test "search by start year" do
    assert_includes Movie.search_by_year(2005), movies(:constantine)
    assert_not_empty Movie.search_by_year(2005)
    refute_includes Movie.search_by_year(2005), movies()
  end

  test "search by score" do
    assert_includes Movie.search_by_score(8), movies(:indiana_jones), movies(:shameless)
    refute_includes Movie.search_by_score(8), movies(:constantine), movies(:avatar)
    assert_not_empty Movie.search_by_score(1)
  end
end
