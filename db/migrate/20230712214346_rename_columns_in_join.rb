class RenameColumnsInJoin < ActiveRecord::Migration[7.0]
  def change
    rename_column :movies_genres, :movies_id, :movie_id
    rename_column :movies_genres, :genres_id, :genre_id
  end
end
