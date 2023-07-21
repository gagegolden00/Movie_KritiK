class Movie < ApplicationRecord
  has_one :review, dependent: :destroy
  has_many :movie_genres, dependent: :destroy
  has_many :genres, :through => :movie_genres

  scope :search_by_term, ->(value) do
          includes(:review)
            .where("lower(title) ILIKE :value OR lower(actors) ILIKE :value OR lower(director) ILIKE :value", value: "%#{value&.downcase}%")
            .order(title: :asc)
        end
  scope :search_by_rating, ->(value) do
          includes(:review)
            .where(rating: value)
            .distinct
            .order(rating: :asc, title: :asc)
        end
  scope :search_by_genre, ->(genres) do
          joins(:genres)
            .where("genres.name IN (?)", genres)
            .includes(:review)
            .distinct
            .order(title: :asc)
        end
  scope :search_by_year, ->(value) do
          where(year: value)
            .includes(:review)
            .order("year ASC")
        end
  scope :search_by_score, ->(value) do
          joins(:review)
            .where("score >= ?", value.to_i)
            .includes(:review)
            .order("score DESC")
        end
end
