class Review < ApplicationRecord
    has_one :movie, dependent: :destroy
    validates :content, presence: true
    validates :score, presence: true
end
