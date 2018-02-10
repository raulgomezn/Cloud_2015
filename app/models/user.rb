class User 
    include Dynamoid::Document #< ActiveRecord::Base
    table :name => :users, :key => :id, :read_capacity => 5, :write_capacity => 5 #:hash_key => { :id => :string },
    
    field :id, :string
    field :firts_name, :string
    field :second_name, :string
    field :last_name, :string
    field :second_last_name, :string
    field :email, :string
    field :password, :string
    field :hash, :serialized
    
    #index :email
    
    has_many :competitions, dependent: :destroy
    
    validates :firts_name, length: { maximum: 50}, presence: true
    validates :second_name, length: { maximum: 50}
    validates :last_name, length: { maximum: 50}, presence: true
    validates :second_last_name, length: { maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { minimum: 10, maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }#, uniqueness: true
    validates :password, length: { maximum: 128, minimum: 6}
    
    #has_many :competitions, dependent: :destroy
    #validates :firts_name, length: { maximum: 50}, presence: true
    #validates :second_name, length: { maximum: 50}
    #validates :last_name, length: { maximum: 50}, presence: true
    #validates :second_last_name, length: { maximum: 50}
    #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    #validates :email, presence: true, length: { minimum: 10, maximum: 255 },
    #format: { with: VALID_EMAIL_REGEX }, uniqueness: true
    #validates :password, length: { maximum: 128, minimum: 6}, presence: has_secure_password

    # key :firts_name, String, :required => true
    # key :second_name, String, :required => false
    # key :last_name, String, :required => true
    # key :second_last_name, String, :required => false
    # key :email, String, :required => true
    # key :password, String
    
    # def self.authenticate(email, secret)
    #     u = User.first(:conditions => {:email => email.downcase})
    #     u && u.authenticated?(secret) ? u : nil
    # end
    
    # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # validates_length_of :firts_name, :within => 6..15
    # validates_length_of :second_name, :within => 6..15
    # validates_length_of :last_name, :within => 6..15
    # validates_length_of :firts_name, :within => 6..15
    # validates_length_of :email,    :within => 10..100, :allow_blank => true
    # validates_format_of :email,    :with => VALID_EMAIL_REGEX, :allow_blank => true
    
    # PasswordRequired = Proc.new { |u| u.password_required? }
    # validates_presence_of :password, :if => PasswordRequired
    # validates_confirmation_of :password, :if => PasswordRequired, :allow_nil => true
    # validates_length_of :password, :minimum => 6, :if => PasswordRequired, :allow_nil => true
    
end
