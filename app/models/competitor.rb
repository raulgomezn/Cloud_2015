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
  
  has_attached_file :video_original,
        :default_url => 'http://s3-sa-east-1.amazonaws.com/unicloudstorage/',
        :storage => :s3,
        :s3_host_name => 's3-sa-east-1.amazonaws.com/',
        :bucket => 'unicloudstorage',
        :s3_credentials => {:bucket => ENV['bucket'], :access_key_id => ENV['access_key_id'], :secret_access_key => ENV['secret_access_key']}
  has_attached_file :video_converted,
        :default_url => 'http://s3-sa-east-1.amazonaws.com/unicloudstorage/',
        :storage => :s3,
        :s3_host_name => 's3-sa-east-1.amazonaws.com/',
        :bucket => 'unicloudstorage',
        :s3_credentials => {:bucket => ENV['bucket'], :access_key_id => ENV['access_key_id'], :secret_access_key => ENV['secret_access_key']}
  validates_attachment_content_type :video_original, content_type: ["video/mp4", "video.mov", "video/mpeg", "video/mpeg4","video/avi","video/x-msvideo"]
  validates_attachment_content_type :video_converted, content_type: ["video/mp4", "video.mov", "video/mpeg", "video/mpeg4","video/avi","video/x-msvideo"]
  
end
