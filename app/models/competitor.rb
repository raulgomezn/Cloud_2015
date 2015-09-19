class Competitor < ActiveRecord::Base
  belongs_to :competition
  validates :first_name, length: { maximum: 50}, presence: true
  validates :second_name, length: { maximum: 50}
  validates :last_name, length: { maximum: 50}, presence: true
  validates :second_last_name, length: { maximum: 50}, presence: true
  validates :email, length: { maximum: 100}, presence: true
  validates :message, length: { maximum: 255}
  validates :status_video, length: { maximum: 50}
  validates :url_video_original, length: { maximum: 255}, presence: true
  validates :url_video_converted, length: { maximum: 255}
end
