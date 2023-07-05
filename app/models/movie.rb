class Movie < ApplicationRecord
    scope :filter_by_title, -> (title) {  where("title like ?", "#{title}%") if :title.present?}
    scope :filter_by_genre, -> (genre) { where genre: genre if :genre.present? }
    scope :filter_by_rating, -> (rating) { where("LOWER(rating) = ?", rating.downcase) if rating.present? }
    scope :filter_by_year, -> (year) {where year: year if :year.present? }
    scope :filter_by_score, -> (score) {where score: score if :score.present? }

    def self.filter_movies(params)
      movies = self.all
      movies = movies.filter_by_title(params[:title]) if params[:title].present?
      movies = movies.filter_by_genre(params[:genre]) if params[:genre].present?
      movies = movies.filter_by_rating(params[:rating]) if params[:rating].present?
      movies = movies.filter_by_year(params[:year]) if params[:year].present?
      movies = movies.filter_by_score(params[:score]) if params[:score].present?
      movies
    end
    
    
    
end
