class RemoveGenreFromMovies < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :genre
  end
end
