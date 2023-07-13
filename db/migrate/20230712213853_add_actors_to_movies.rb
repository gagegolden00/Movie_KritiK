class AddActorsToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :actors, :string
  end
end
