class Movie < ApplicationRecord
  has_one :review, dependent: :destroy
  has_many :movie_genres, dependent: :destroy
  has_many :genres, :through => :movie_genres

  # scopes exit

  # text title search
  scope :search_by_title, ->(value) { includes(:review).where("lower(title) LIKE ?", "%#{value&.downcase}%") }
  scope :search_by_rating, ->(value) { where("rating LIKE ?", "%#{value&.upcase}%") }
  scope :search_by_year, ->(value) { where("(year) LIKE ?", "%#{value}%") }
  scope :search_by_genre, ->(value) { joins(:genres).where("(genres.name) LIKE ?", "%#{value}%") }
  scope :search_by_score, ->(value) { joins(:review).where("reviews.score >= ?", value.to_i) }
end
