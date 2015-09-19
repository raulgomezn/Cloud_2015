class User < ActiveRecord::Base
    #extend ActiveModel::Naming
    
    #validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
    #validates :validate_email, true
    #validates :validate_pass, true
    def new
        @user = User.new
    end 
    
    def validate_email
        errors.add(:email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }) 
    end
    
    def validate_pass
        errors.add(:password, presence: true, length: { minimum: 6 })
    end
end
