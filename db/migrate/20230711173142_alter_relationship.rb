class AlterRelationship < ActiveRecord::Migration[7.0]
  def change
    remove_reference :movies, :review, index: true, foreign_key: true
  end
end
