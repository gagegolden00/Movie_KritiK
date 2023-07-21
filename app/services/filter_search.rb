class FilterSearch
  def initialize(term, genre, year, rating, score)
    @term = term
    @genre = genre
    @year = year
    @rating = rating
    @score = score
  end

  def execute_search
    @movies = Movie.search_by_term(@term)
      .search_by_genre(@genre)
      .search_by_year(@year)
      .search_by_rating(@rating)
      .search_by_score(@score)
    @movies
  end
end
