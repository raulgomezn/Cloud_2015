class Competition < ActiveRecord::Base
  belongs_to :user
  has_many :competitors, dependent: :destroy
  validates :name, length: { maximum: 100}, presence: true
  validates :url, length: { maximum: 100}, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :prize, length: { maximum: 255}
  #validates :banner, presence: true
  has_attached_file :banner,
        :styles => { :medium => "1024x120>"},
        # :default_url => 'https://s3-sa-east-1.amazonaws.com',
        :storage => :s3,
        :bucket => 'unicloudstorage'
        #:s3_credentials => '#{Rails.root}/config/aws.yml',
        #     :url => "/:image/:id/:style/:basename.:extension",
        #     :path => ":image/:id/:style/:basename.:extension"
  

  validates_attachment_content_type :banner, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
