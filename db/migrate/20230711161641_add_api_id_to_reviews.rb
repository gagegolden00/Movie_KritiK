class AddApiIdToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :api_movie_id, :string
  end
end
