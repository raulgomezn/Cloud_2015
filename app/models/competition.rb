class Competition < ActiveRecord::Base
  belongs_to :users
  validates :name, length: { maximum: 100}, presence: true
  validates :url, length: { maximum: 100}, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :prize, length: { maximum: 255}
  validates :image, length: { maximum: 255}
end
