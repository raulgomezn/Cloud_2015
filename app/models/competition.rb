class Competition < ActiveRecord::Base
  belongs_to :user
  has_many :competitors
  validates :name, length: { maximum: 100}, presence: true
  #validates :url, length: { maximum: 100}, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :prize, length: { maximum: 255}
  validates :banner, presence: true
  VALID_URL_REGEX = /(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9]))*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])\z/
  validates :url, presence: true, length: { minimum: 4, maximum: 15 },
  format: { with: VALID_URL_REGEX }, uniqueness: true
  
  has_attached_file :banner,
  :styles => { :medium => "1024x120>"},
  :default_url => 'http://s3-sa-east-1.amazonaws.com/unicloudstorage/',
  :storage => :s3,
  :s3_host_name => 's3-sa-east-1.amazonaws.com/',
  :bucket => 'unicloudstorage',
  :s3_credentials => {:bucket => ENV['bucket'], :access_key_id => ENV['access_key_id'], :secret_access_key => ENV['secret_access_key']}

  validates_attachment_content_type :banner, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
