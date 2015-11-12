class User 
    include Dynamoid::Document
    table :name => :users, :key => :id, :read_capacity => 5, :write_capacity => 5
    
    field :id, :string
    field :firts_name, :string
    field :second_name, :string
    field :last_name, :string
    field :second_last_name, :string
    field :email, :string
    field :password, :string
    field :hash, :serialized
    
    has_many :competitions, dependent: :destroy
    
    validates :firts_name, length: { maximum: 50}, presence: true
    validates :second_name, length: { maximum: 50}
    validates :last_name, length: { maximum: 50}, presence: true
    validates :second_last_name, length: { maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { minimum: 10, maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }
    validates :password, length: { maximum: 128, minimum: 6}
    
end