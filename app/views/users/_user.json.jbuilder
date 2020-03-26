json.extract! user, :id, :latidute, :longitude, :name, :confirmed, :recovered, :death, :created_at, :updated_at
json.url user_url(user, format: :json)
