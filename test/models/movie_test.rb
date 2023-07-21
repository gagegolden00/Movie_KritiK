require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  test "search_by_term returns movies matching the search term in title" do
    movie1 = new(:movie, title: "Batman")
    movie2 = new(:movie, title: "Demon")

    assert_includes Movie.search_by_term("Batman"), movie1
    refute_includes Movie.search_by_term("Demon"), movie2
  end

  test "search_by_term returns movies matching the search term in actors" do
    movie1 = new(:movie, actors: "Robert Downey Jr.")
    movie2 = new(:movie, actors: "Christian Bale")

    assert_includes Movie.search_by_term("Downey"), movie1
    refute_includes Movie.search_by_term("Downey"), movie2
  end

  test "search_by_term returns movies matching the search term in director" do
    movie1 = new(:movie, director: "Joss Whedon")
    movie2 = new(:movie, director: "Christopher Nolan")

    assert_includes Movie.search_by_term("Whedon"), movie1
    refute_includes Movie.search_by_term("Whedon"), movie2
  end

  test "search_by_term is case-insensitive" do
    movie1 = new(:movie, title: "Demon")
    movie2 = new(:movie, title: "Batman")
    assert_includes Movie.search_by_term("avengers"), movie1
    refute_includes Movie.search_by_term("avengers"), movie2
  end
end
