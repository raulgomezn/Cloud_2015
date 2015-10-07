class Competitor < ActiveRecord::Base
  
  belongs_to :competition
  validates :first_name, length: { maximum: 50}, presence: true
  validates :second_name, length: { maximum: 50}
  validates :last_name, length: { maximum: 50}, presence: true
  validates :second_last_name, length: { maximum: 50}, presence: true
  validates :email, length: { maximum: 100}, presence: true
  validates :message, length: { maximum: 255}
  validates :status_video, length: { maximum: 50}
  #validates :video_original, presence: true
  
  has_attached_file :video_original
  has_attached_file :video_converted
  validates_attachment_content_type :video_original, content_type: ["video/mp4", "video.mov", "video/mpeg", "video/mpeg4","video/avi","video/x-msvideo"]
  validates_attachment_content_type :video_converted, content_type: ["video/mp4", "video.mov", "video/mpeg", "video/mpeg4","video/avi","video/x-msvideo"]
  
end
