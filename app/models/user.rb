class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memes
  has_many :comments
  mount_uploader :avatar, AvatarUploader
 	
 	validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: 2 }
  validates :email, uniqueness: true
  validates :avatar, presence: true
end
