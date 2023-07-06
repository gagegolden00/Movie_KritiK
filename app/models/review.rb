class Review < ApplicationRecord
    belongs_to :movie
    scope :filter_by_title, -> (title) { where("LOWER(title) LIKE ?", "%#{title.downcase}%") if title.present? }

end
