class GenreCreator
    def self.create_genre(movie_data_hash)
        genre_csv = movie_data_hash['Genre']
        genre_names = genre_csv.split(", ").map(&:strip)
        genre_names.map do |genre|
          unless Genre.find_by(name: genre)
            Genre.new(name: genre)
          end
        end
        genre_names
    end
end