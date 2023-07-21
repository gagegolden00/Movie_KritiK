class Movie < ApplicationRecord
  has_one :review, dependent: :destroy
  has_many :movie_genres, dependent: :destroy
  has_many :genres, :through => :movie_genres

  scope :search_by_term, ->(value) do
          if value.present?
            includes(:review)
              .where("lower(title) ILIKE :value OR lower(actors) ILIKE :value OR lower(director) ILIKE :value", value: "%#{value&.downcase}%")
              .order(title: :asc)
          end
        end

  scope :search_by_rating, ->(value) do
          if value.present?
            includes(:review)
              .where(rating: value)
              .distinct
              .order(rating: :asc, title: :asc)
          end
        end

  scope :search_by_genre, ->(value) do
          if value.present?
            joins(:genres)
              .where("genres.name IN (?)", value)
              .includes(:review)
              .distinct
              .order(title: :asc)
          end
        end

  scope :search_by_year, ->(years) do
          if years.present?
            where("year ILIKE ANY (array[?])", "#{years}%")
              .includes(:review)
              .order("year ASC")
          end
        end

  scope :search_by_score, ->(value) do
          if value.present?
            joins(:review)
              .where("score >= ?", value.to_i)
              .includes(:review)
              .order("score DESC")
          end
        end
end
