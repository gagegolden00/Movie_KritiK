class ChangeTempYearToStartYear < ActiveRecord::Migration[7.0]
  def change
    rename_column :movies, :temp_start_year, :start_year
  end
end
