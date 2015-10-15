json.array!(@competitions) do |competition|
  json.extract! competition, :id, :users_id, :name, :url, :start_date, :end_date, :prize, :image
  json.url competition_url(competition, format: :json)
end
