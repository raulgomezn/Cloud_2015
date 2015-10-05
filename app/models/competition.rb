class Competition < ActiveRecord::Base
  belongs_to :users
  has_many :competitors, dependent: :destroy
  validates :name, length: { maximum: 100}, presence: true
  validates :url, length: { maximum: 100}, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :prize, length: { maximum: 255}
  #validates :image, length: { maximum: 255}
  #validates :banner, presence: true
  
  has_attached_file :banner,
  #:path => ":rails_root/public/system/:attachment/:id/:style/:filename",
  #:url => "/system/:attachment/:id/:style/:filename",
  :styles => { :medium => "1024x120>"}
  
  validates_attachment_content_type :banner, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
