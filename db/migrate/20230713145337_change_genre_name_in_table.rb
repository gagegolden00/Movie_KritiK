class ChangeGenreNameInTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :genres, :genre, :name
  end
end
