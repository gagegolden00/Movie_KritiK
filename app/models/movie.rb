class Movie < ApplicationRecord
    # old search form
    def self.search(title, year, genre, rating, score)
        movies = Movie.all
        movies = movies.where("title LIKE ?", "%#{title}%") if title.present?
        movies = movies.where(year: year) if year.present? && year != "Release Year"
        movies = movies.where(genre: genre) if genre.present? && genre != "Genre"
        movies = movies.where(rating: rating) if rating.present? && rating != "Rating"
        movies = movies.where(score: score) if score.present? && score != "Score"
        movies
    end
    
end
