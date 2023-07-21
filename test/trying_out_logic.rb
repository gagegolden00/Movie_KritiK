require 'active_record'

# Define the Movie class
class Movie < ActiveRecord::Base
end


class TestLogic < ApplicationRecord::Base

  movies.map do |m|
    if m.year.length == 4
      int_year = m.year.to_i
      puts int_year
    end
  end
end
