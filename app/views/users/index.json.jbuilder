json.array!(@users) do |user|
  json.extract! user, :id, :firts_name, :second_name, :last_name, :second_last_name, :email, :password, :IsAdmin
  json.url user_url(user, format: :json)
end
