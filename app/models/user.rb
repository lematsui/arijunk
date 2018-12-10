class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :memes
  has_many :comments
 	
 	validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: 2 }
  validates :bio, length: { minimum: 50, too_short: "IT NEEDS TO BE LONGER THAN THAT" }
  validates :avatar, presence: true
end
