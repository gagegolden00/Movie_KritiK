class Movie < ApplicationRecord
  has_one :review, dependent: :destroy
  has_many :movie_genres, dependent: :destroy
  has_many :genres, :through => :movie_genres

  # scopes 

  # text title search 
  scope :search_by_title, -> (search_term) { where("lower(title) LIKE ?", "%#{search_term.downcase}%") }
  # display avaliable checkboxes dynamically
  


end
