class MovieCreator
    def self.create_movie(movie_data_hash)
        movie = Movie.new(
        title: movie_data_hash['Title'],
        year: movie_data_hash['Year'],
        genre: movie_data_hash['Genre'],
        rating: movie_data_hash['Rated']
        )
        movie.save!
    end
end
  


