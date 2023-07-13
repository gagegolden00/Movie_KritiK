class CreateMovieGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_genres do |t|
      t.belongs_to :movies
      t.belongs_to :genres
    end
  end
end
