class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attr_accessor :username

  has_many :memes
  has_many :comments
  mount_uploader :avatar, AvatarUploader
 	
  validates :email, uniqueness: true
 	# validates :username, presence: true
  # validates :username, uniqueness: true
  validates :username, length: { minimum: 2 }
  # validates :avatar, presence: true
end
