class CreateJoin < ActiveRecord::Migration[7.0]
  def change
    create_table :movies_reviews, id: false do |t|
      t.belongs_to :movies
      t.belongs_to :genres
    end
  end
end
