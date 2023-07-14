class Review < ApplicationRecord
    scope :find_by_api_movie_id, -> (api_movie_id) { where(api_movie_id: api_movie_id) }


    belongs_to :movie #dependent: :destroy
    #validates :content, presence: true
    #validates :score, presence: true,
     #numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
end
