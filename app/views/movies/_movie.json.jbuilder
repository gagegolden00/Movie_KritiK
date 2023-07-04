json.extract! movie, :id, :title, :review, :created_at, :updated_at
json.url movie_url(movie, format: :json)
