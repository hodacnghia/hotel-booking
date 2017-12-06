json.extract! hotel, :id, :name, :description, :user_id, :created_at, :updated_at
json.url hotel_url(hotel, format: :json)
