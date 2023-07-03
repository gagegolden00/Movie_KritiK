json.extract! review, :id, :title, :review, :created_at, :updated_at
json.url review_url(review, format: :json)
