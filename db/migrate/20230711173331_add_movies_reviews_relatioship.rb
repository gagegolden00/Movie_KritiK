class AddMoviesReviewsRelatioship < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :movies, foreign_key: true, index: { unique: true }
  end
end
