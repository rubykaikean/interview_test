json.array!(@users) do |user|
  json.extract! user, :id, :name, :age, :address, :addition_info
  json.url user_url(user, format: :json)
end
