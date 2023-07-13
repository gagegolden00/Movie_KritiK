class RenameJoinColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :movie_genres, :movies_id, :movie_id
    rename_column :movie_genres, :genres_id, :genre_id
  end
end
