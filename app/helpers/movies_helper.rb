module MoviesHelper
  def structure_movie_genres(movie)
    unformatted_movie_genres = ""
    movie.genres.each do |genre|
      unformatted_movie_genres << genre.name
    end
    formatted_movie_genres = unformatted_movie_genres.gsub(/(?<=\p{Lu})(?=\p{Lu}\p{Ll})|(?<=\p{Ll})(?=\p{Lu})/, ", ")
    formatted_movie_genres
  end
end
