json.extract! device, :id, :name, :location_id, :kind, :created_at, :updated_at
json.url device_url(device, format: :json)
