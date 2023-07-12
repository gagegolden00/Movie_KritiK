class AddToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :runtime, :string
    add_column :movies, :director, :string
    add_column :movies, :plot, :text
    add_column :movies, :language, :string
    add_column :movies, :awards, :string
    add_column :movies, :poster, :string
  end
end
