class Movie < ApplicationRecord
  belongs_to :review, optional: true
  # now if the movie for some reason is not saved we should use a job to go and retrieve the 
  # data from the API and save it then when browsing the movies index. Will need a condition to 
  # check if the movie is already in the database. and if not we use another api request but the trick 
  # is to make sure the review gets assiciaoted with that movie or vice versa I guess. 

  scope :filter_by_title, -> (title) { where("LOWER(REPLACE(title, ' ', '')) LIKE ?", "%#{title.downcase.gsub(' ', '')}%") if title.present? }
  scope :filter_by_genre, -> (genres) {
    genres = Array(genres).compact
    where(genre: genres) if genres.present?
  }
  
  scope :filter_by_rating, -> (ratings) {
    ratings = Array(ratings).compact.map(&:downcase)
    where("LOWER(rating) IN (?)", ratings) if ratings.present?
  }
  
  scope :filter_by_year, -> (years) {
    years = Array(years).compact
    where(year: years) if years.present?
  }
  
  scope :filter_by_score, -> (scores) {
    scores = Array(scores).compact
    where(score: scores) if scores.present?
  }

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
