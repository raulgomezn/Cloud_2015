json.array!(@competitors) do |competitor|
  json.extract! competitor, :id, :competition_id, :first_name, :second_name, :last_name, :second_last_name, :date_admission, :email, :message, :status_video, :url_video_original, :url_video_converted
  json.url competitor_url(competitor, format: :json)
end
