class FixReference < ActiveRecord::Migration[7.0]
  def change
        remove_foreign_key :reviews, :movies
        remove_column :reviews, :movies_id
        add_reference :reviews, :movie, foreign_key: true
  end
end
