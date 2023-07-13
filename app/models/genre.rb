class Genre < ApplicationRecord
    has_many :movie_genres, dependent: :destroy
    has_many :movies, :through => :movie_genres
    #has_and_belongs_to_many :movies, join_table: :movie_genres
end
