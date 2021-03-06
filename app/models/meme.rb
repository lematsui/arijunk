class Meme < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  mount_uploader :photo, PhotoUploader

  validates :photo, presence: true
  validates :title, presence: true
end
