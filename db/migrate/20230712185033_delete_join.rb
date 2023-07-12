class DeleteJoin < ActiveRecord::Migration[7.0]
  def change
    drop_table :movies_genres
  end
end
