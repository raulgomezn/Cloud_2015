class User < ActiveRecord::Base
    has_many :competitions
    validates :firts_name, length: { maximum: 50}, presence: true
    validates :second_name, length: { maximum: 50}
    validates :last_name, length: { maximum: 50}, presence: true
    validates :second_last_name, length: { maximum: 50}
    validates :email, length: { maximum: 100, minimum: 10}, presence: true
    validates :password, length: { maximum: 128, minimum: 6}, presence: true
end
