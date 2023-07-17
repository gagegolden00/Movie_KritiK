class Movie < ApplicationRecord
  has_one :review, dependent: :destroy
  has_many :movie_genres, dependent: :destroy
  has_many :genres, :through => :movie_genres

  # scope practice 
  # scope :find_by_api_movie_id, -> (api_movie_id) { where(api_movie_id: api_movie_id) }

  #scope :find_by_movie_id, -> (movie_id)




end
