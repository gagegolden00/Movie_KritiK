class AddForeignKeysToMoviesGenres < ActiveRecord::Migration[7.0]
  def change
    create_table "movies_genres", id: false, force: :cascade do |t|
      t.bigint "movie_id"
      t.bigint "genre_id"
      t.index ["genre_id"], name: "index_movies_genres_on_genre_id"
      t.index ["movie_id"], name: "index_movies_genres_on_movie_id"
      t.foreign_key "movies", column: "movie_id"
      t.foreign_key "genres", column: "genre_id"
    end
  end
end
