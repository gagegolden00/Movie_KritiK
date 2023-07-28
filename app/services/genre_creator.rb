class GenreCreator
  def self.create_genre(movie_data_hash)
    existing_genres_in_database = Genre.pluck(:name)
    genre_csv = movie_data_hash["Genre"]
    genre_names = genre_csv.split(", ").map(&:strip)
    genre_names.map do |genre|
      unless existing_genres_in_database.include?(genre)
        Genre.create(name: genre)
      end
    end
    genre_names
  end
end
