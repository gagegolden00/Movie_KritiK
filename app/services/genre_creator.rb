class GenreCreator
    def self.create_genre(movie_data_hash)
        genre_string = movie_data_hash['Genre']
        genres = genre_string.split(", ").map(&:strip)
      
        genres.each do |genre|
          unless Genre.find_by(genre: genre)
            Genre.create(genre: genre)
          end
        end
      end
      
end