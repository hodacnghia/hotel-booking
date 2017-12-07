json.extract! room, :id, :type_id, :hotel_id, :bed, :status, :created_at, :updated_at
json.url room_url(room, format: :json)
