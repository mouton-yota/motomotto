class Post < ApplicationRecord
  acts_as_taggable
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :image

  validates :image, presence: true
end
