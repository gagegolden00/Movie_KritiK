class Fixdatabase < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.bigint :movie_id, null: false
      t.text :content
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false

      t.index :movie_id, unique: true
    end

    add_foreign_key :reviews, :movies
  end
end
