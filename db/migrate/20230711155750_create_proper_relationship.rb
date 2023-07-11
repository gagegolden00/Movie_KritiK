class CreateProperRelationship < ActiveRecord::Migration[7.0]
  def change
    add_reference :movies, :review, foreign_key: true, index: { unique: true }
  end
end
