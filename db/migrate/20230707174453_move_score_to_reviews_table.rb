class MoveScoreToReviewsTable < ActiveRecord::Migration[7.0]
  def change
    # Remove the reviews_id column and foreign key from the movies table
    #remove_column :movies, :review_id
    #remove_foreign_key :movies, :reviews

    # Remove the score column from the movies table
    remove_column :movies, :score

    # Add the score column to the reviews table
    add_column :reviews, :score, :integer
  end
end

