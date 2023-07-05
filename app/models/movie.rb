class Movie < ApplicationRecord
    scope :filter_by_title, -> (title) {  where("title like ?", "#{title}%") if :title.present?}
    scope :filter_by_genre, -> (genre) { where genre: genre if :genre.present? }
    scope :filter_by_rating, -> (rating) {where("rating like ?", "#{rating}%") if :rating.present? }
    scope :filter_by_year, -> (year) {where year: year if :year.present? }
    scope :filter_by_score, -> (score) {where score: score if :score.present? }
end
