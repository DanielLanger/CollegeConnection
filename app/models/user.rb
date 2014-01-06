class User < ActiveRecord::Base

  has_one :quiz
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :position, :remember_me, :facebook, :bio, :photo, :from
  validates :name, :presence => true
  validates_length_of :name, :maximum=>30
  validates_format_of :name, :with => /^[a-z ]+$/i,
  :message => "can only contain letters"
  validates :email, :presence => true
  validates :email, :uniqueness => true
  validates :position, :presence => true

  
  has_attached_file :photo, :styles =>{:small => "150x150>", :thumbnail => "50x50>"},
  :storage => :s3,
  :s3_credentials => "#{Rails.root}/config/s3.yml",
  :path => ":attachment/:id/:style.:extension",
  :bucket => 'CollegeConnect'

end
