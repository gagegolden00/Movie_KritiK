class MovieCreator
  def self.create_movie(movie_data_hash, genres)
    binding.pry

    start_year_param = movie_data_hash["Year"][0..3]
    end_year_param = movie_data_hash["Year"].length == 9 ? movie_data_hash["Year"][5..8] : nil


    movie = Movie.new(
      title: movie_data_hash["Title"],
      start_year: start_year_param,
      end_year: end_year_param,
      rating: movie_data_hash["Rated"],
      runtime: movie_data_hash["Runtime"],
      director: movie_data_hash["Director"],
      plot: movie_data_hash["Plot"],
      language: movie_data_hash["Language"],
      awards: movie_data_hash["Awards"],
      poster: movie_data_hash["Poster"],
      actors: movie_data_hash["Actors"],
      #api_movie_id: movie_data_hash['
    )
    genres.each do |genre_name|
      genre = Genre.find_by(name: genre_name)
      movie.genres << genre
    end
    movie.save
    movie
  end
end
