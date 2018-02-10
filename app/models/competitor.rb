class Competitor
  include Dynamoid::Document #< ActiveRecord::Base
  include Dynamoid::Paperclip
  
  has_dynamoid_attached_file :video_original,
        :default_url => 'http://s3-sa-east-1.amazonaws.com/unicloudstorage/',
        :storage => :s3,
        :s3_host_name => 's3-sa-east-1.amazonaws.com/',
        :bucket => 'unicloudstorage',
        :s3_credentials => {:bucket => ENV['bucket'], :access_key_id => ENV['access_key_id'], :secret_access_key => ENV['secret_access_key']}
  has_dynamoid_attached_file :video_converted,
        :default_url => 'http://s3-sa-east-1.amazonaws.com/unicloudstorage/',
        :storage => :s3,
        :s3_host_name => 's3-sa-east-1.amazonaws.com/',
        :bucket => 'unicloudstorage',
        :s3_credentials => {:bucket => ENV['bucket'], :access_key_id => ENV['access_key_id'], :secret_access_key => ENV['secret_access_key']}
  
  table :name => :competitors, :key => :id, :read_capacity => 5, :write_capacity => 5

  field :id, :string
  field :first_name,  :string
  field :second_name,  :string
  field :last_name,  :string
  field :second_last_name,  :string
  field :date_admission,  :datetime
  field :email,  :string
  field :message,  :string
  field :status_video,  :string
  field :competitions_id,  :string
  field :hash, :serialized
  
  field :video_converted_file_name,  :string
  
  #index :email
    
  belongs_to :competition, dependent: :destroy
  
  validates :first_name, length: { maximum: 50}, presence: true
  validates :second_name, length: { maximum: 50}
  validates :last_name, length: { maximum: 50}, presence: true
  validates :second_last_name, length: { maximum: 50}, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { minimum: 5, maximum: 100}, format: { with: VALID_EMAIL_REGEX }, presence: true
  validates :message, length: { maximum: 255}
  validates :status_video, length: { maximum: 50}
  #validates :video_original, presence: true
  
  
  #validates_attachment_content_type :video_original, content_type: ["video/mp4", "video.mov", "video/mpeg", "video/mpeg4","video/avi","video/x-msvideo"]
  #validates_attachment_content_type :video_converted, content_type: ["video/mp4", "video.mov", "video/mpeg", "video/mpeg4","video/avi","video/x-msvideo"]
  
end
