class Movie < ApplicationRecord
    scope :filter_by_title, -> (title) {  where("title like ?", "#{title}%") }
    scope :filter_by_genre, -> (genre) { where genre: genre }
    scope :filter_by_rating, -> (rating) {where("rating like ?", "#{rating}%") }
    scope :filter_by_year, -> (year) {where year: year }
    scope :filter_by_score, -> (score) {where score: score }

    
end
