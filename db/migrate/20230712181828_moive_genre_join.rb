class MoiveGenreJoin < ActiveRecord::Migration[7.0]
  def change
    create_table :movies_genres, id: false do |t|
      t.references :movie, foreign_key: true
      t.references :genre, foreign_key: true
    end
  end
end
