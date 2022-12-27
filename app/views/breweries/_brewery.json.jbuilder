json.extract! brewery, :id, :name, :year, :active, :created_at, :updated_at, :beers
json.url brewery_url(brewery, format: :json)
