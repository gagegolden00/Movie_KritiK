class ReplaceScoreToReviews < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :score, :integer

    add_column :reviews, :score, :integer
  end
end
