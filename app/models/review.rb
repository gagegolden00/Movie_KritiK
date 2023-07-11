class Review < ApplicationRecord
    belongs_to :movie #dependent: :destroy
    #validates :content, presence: true
    #validates :score, presence: true
end
