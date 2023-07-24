# test/models/movie_test.rb
require "test_helper"

class MovieTest < ActiveSupport::TestCase

  fixtures :movies, :genres, :movies_genres, :reviews

  ## SEARCH BY TERM TESTS ##
  test "search_by_term returns movies matching the search term in title" do
    movie1 = Movie.create(title: "Batman")
    movie2 = Movie.create(title: "Demon")

    assert_includes Movie.search_by_term("Batman".downcase), movie1
    refute_includes Movie.search_by_term("Batman".downcase), movie2
  end

  test "search_by_term returns movies matching the search term in actors" do
    movie1 = Movie.create(actors: "Robert Downey Jr.".downcase)
    movie2 = Movie.create(actors: "Christian Bale".downcase)

    assert_includes Movie.search_by_term("Downey"), movie1
    refute_includes Movie.search_by_term("Downey"), movie2
  end

  test "search_by_term returns movies matching the search term in director" do
    movie1 = Movie.create(director: "Joss Whedon")
    movie2 = Movie.create(director: "Christopher Nolan")

    assert_includes Movie.search_by_term("Whedon"), movie1
    refute_includes Movie.search_by_term("Whedon"), movie2
  end

  test "search_by_term is case-insensitive" do
    movie1 = Movie.create(title: "Avengers")
    movie2 = Movie.create(title: "Ted")

    # Ensure the search term is case-insensitive by downcasing it.
    assert_includes Movie.search_by_term("Avengers".downcase), movie1
    refute_includes Movie.search_by_term("avengers".downcase), movie2
  end

  ## SEARCH BY RATING TESTS ##

  test "search_by_rating returns movies matching the search rating" do
    movie1 = Movie.create(rating: "G")
    movie2 = Movie.create(rating: "PG")
    movie3 = Movie.create(rating: "PG-13")
    movie4 = Movie.create(rating: "R")
    movie5 = Movie.create(rating: "N/A")
    movie6 = Movie.create(rating: "TV-14")
    movie7 = Movie.create(rating: "TV-MA")
    movie8 = Movie.create(rating: "TV-PG")

    movie11 = Movie.create(rating: "G")
    movie12 = Movie.create(rating: "PG")
    movie13 = Movie.create(rating: "PG-13")
    movie14 = Movie.create(rating: "R")
    movie15 = Movie.create(rating: "N/A")
    movie16 = Movie.create(rating: "TV-14")
    movie17 = Movie.create(rating: "TV-MA")
    movie18 = Movie.create(rating: "TV-PG")

    # return & refute single movie
    assert_includes Movie.search_by_rating("G"), movie1
    refute_includes Movie.search_by_rating("G"), movie2
    assert_includes Movie.search_by_rating("PG"), movie2
    refute_includes Movie.search_by_rating("PG"), movie3
    assert_includes Movie.search_by_rating("PG-13"), movie3
    refute_includes Movie.search_by_rating("PG-13"), movie4
    assert_includes Movie.search_by_rating("R"), movie4
    refute_includes Movie.search_by_rating("R"), movie5
    assert_includes Movie.search_by_rating("N/A"), movie5
    refute_includes Movie.search_by_rating("N/A"), movie6
    assert_includes Movie.search_by_rating("TV-14"), movie6
    refute_includes Movie.search_by_rating("TV-14"), movie7
    assert_includes Movie.search_by_rating("TV-MA"), movie7
    refute_includes Movie.search_by_rating("TV-MA"), movie8
    assert_includes Movie.search_by_rating("TV-PG"), movie8
    refute_includes Movie.search_by_rating("TV-PG"), movie1

    # return & refute multiple movies
    assert_includes Movie.search_by_rating("G"), movie1, movie11
    refute_includes Movie.search_by_rating("G"), movie2, movie12
    assert_includes Movie.search_by_rating("PG"), movie2, movie12
    refute_includes Movie.search_by_rating("PG"), movie3, movie13
    assert_includes Movie.search_by_rating("PG-13"), movie3, movie13
    refute_includes Movie.search_by_rating("PG-13"), movie4, movie14
    assert_includes Movie.search_by_rating("R"), movie4, movie14
    refute_includes Movie.search_by_rating("R"), movie5, movie15
    assert_includes Movie.search_by_rating("N/A"), movie5, movie15
    refute_includes Movie.search_by_rating("N/A"), movie6, movie16
    assert_includes Movie.search_by_rating("TV-14"), movie6, movie16
    refute_includes Movie.search_by_rating("TV-14"), movie7, movie17
    assert_includes Movie.search_by_rating("TV-MA"), movie7, movie17
    refute_includes Movie.search_by_rating("TV-MA"), movie8, movie18
    assert_includes Movie.search_by_rating("TV-PG"), movie8, movie18
    refute_includes Movie.search_by_rating("TV-PG"), movie1, movie11
  end

  ## SEARCH BY GENRE TESTS ##

  test "search_by_genre_tests" do
    # Define some genres
    action = Genre.create(name: "Action")
    comedy = Genre.create(name: "Comedy")
    adventure = Genre.create(name: "Adventure")

    # Create some movies to insert some genres into because obviously genres is its own table
    movie1 = Movie.create(title: "Movie 1")
    movie2 = Movie.create(title: "Movie 2")
    movie3 = Movie.create(title: "Movie 3")
    movie4 = Movie.create(title: "Movie 4")

    # Insert some genres
    movie1.genres.push(action, comedy)
    movie2.genres.push(comedy, adventure)
    movie3.genres.push(adventure)
    movie4.genres.push(action, adventure, comedy)

    # Test movies with genres present
    assert_includes Movie.search_by_genre(["Action"]), movie1
    refute_includes Movie.search_by_genre(["Action"]), movie2, movie3
    assert_includes Movie.search_by_genre(["Comedy"]), movie1, movie2
    refute_includes Movie.search_by_genre(["Comedy"]), movie3
    assert_includes Movie.search_by_genre(["Adventure"]), movie2, movie3
    refute_includes Movie.search_by_genre(["Adventure"]), movie1
    assert_includes Movie.search_by_genre(["Action", "Comedy"]), movie1, movie2
    refute_includes Movie.search_by_genre(["Action", "Comedy"]), movie3
    assert_includes Movie.search_by_genre(["Adventure", "Action"]), movie1, movie3
    refute_includes Movie.search_by_genre(["Adventure", "Action"]), nil
    assert_includes Movie.search_by_genre(["Action", "Comedy", "Adventure"]), movie4
    refute_includes Movie.search_by_genre(["Action", "Comedy", "Adventure"]), nil
  end

  ## SEARCH BY YEAR TESTS ##

  test "search by start year" do
    movie1 = Movie.create(start_year: 2001)
    movie2 = Movie.create(start_year: 2002)
    movie3 = Movie.create(start_year: 2003)

    assert_includes Movie.search_by_year(2001), movie1
    refute_includes Movie.search_by_year(2001), movie2, movie3
    assert_includes Movie.search_by_year(2002), movie2
    refute_includes Movie.search_by_year(2002), movie1, movie3
  end

  test "search by score" do
    scores = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10']


    movie0 = Movie.create(title: "Movie 0")
    review0 = movie0.review.create
    movie1 = Movie.create(title: "Movie 1")
    movie2 = Movie.create(title: "Movie 2")
    movie3 = Movie.create(title: "Movie 3")
    movie4 = Movie.create(title: "Movie 4")
    movie5 = Movie.create(title: "Movie 5")
    movie6 = Movie.create(title: "Movie 6")
    movie7 = Movie.create(title: "Movie 7")
    movie8 = Movie.create(title: "Movie 8")
    movie9 = Movie.create(title: "Movie 9")
    movie10 = Movie.create(title: "Movie 10")
  end
end
