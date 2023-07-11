class RemoveReviewsFromMovies < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :reviews
  end
end
