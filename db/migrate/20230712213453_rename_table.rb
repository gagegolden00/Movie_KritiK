class RenameTable < ActiveRecord::Migration[7.0]
  def change
    rename_table :movies_reviews, :movies_genres
  end
end
