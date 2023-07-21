module MoviesHelper
  def structure_movie_genres(movie)
    unformatted_movie_genres = ""
    movie.genres.each do |genre|
      unformatted_movie_genres << genre.name
    end
    formatted_movie_genres = unformatted_movie_genres.gsub(/(?<=\p{Lu})(?=\p{Lu}\p{Ll})|(?<=\p{Ll})(?=\p{Lu})/, ", ")
    formatted_movie_genres
  end


  private
  
  # temporary table will be renamed and used as primary but for now so I dont lose data it is named temporary
  def save_start_years_to_temp_start_year_column
    movies = Movie.all
    int_years = movies.map do |m|
      start_year_as_integer = m.year[0..3].to_i
      m.update(temp_start_year: start_year_as_integer)
      start_year_as_integer
    end
    puts int_years
  end
  def save_end_year_to_end_year_column
    movies = Movie.all
    int_years = movies.map do |m|
      if m.year.length == 9
        end_year_as_integer = m.year[5..8].to_i
        m.update(end_year: end_year_as_integer)
      end
    end
  end
end
