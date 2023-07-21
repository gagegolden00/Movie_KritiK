class CreateTempTableAndEndDateTable < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :temp_start_year, :integer
    add_column :movies, :end_year, :integer
  end
end
