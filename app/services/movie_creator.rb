class MovieCreator
    def self.create_movie(movie_data_hash)

        @movie_to_save = Movie.create!(
        title: movie_data_hash['Title'], 
        year: movie_data_hash['Year'],
        genre: movie_data_hash['Genre'],         
        rating: movie_data_hash['Rated']
        )
        #binding.pry

        @movie_to_save.save!
    rescue ActiveRecord::RecordNotUnique => e
        puts e.message
    end
end

