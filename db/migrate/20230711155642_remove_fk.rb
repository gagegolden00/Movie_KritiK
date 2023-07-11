class RemoveFk < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :reviews, :movies
    remove_reference :reviews, :movie, index: true
  end
end
