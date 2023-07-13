class MovieCreator
    def self.create_movie(movie_data_hash)
        movie = Movie.new(
        title: movie_data_hash['Title'],
        year: movie_data_hash['Year'],
        rating: movie_data_hash['Rated'], 
        runtime: movie_data_hash['Runtime'], 
        director: movie_data_hash['Director'],
        plot: movie_data_hash['Plot'],
        language: movie_data_hash['Language'],
        awards: movie_data_hash['Awards'], 
        poster: movie_data_hash['Poster'],
        actors: movie_data_hash['Actors']
        )
        movie.save!
    end
end
  


