class AddToMoviesColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :year, :integer
    add_column :movies, :genre, :string
    add_column :movies, :rating, :float
    add_column :movies, :score, :integer
  end
end
