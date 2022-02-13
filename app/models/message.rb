class Message < ApplicationRecord

  belongs_to :user
  belongs_to :room
  has_many :comments, dependent: :destroy
  attachment :post_image

  validates :words, presence: true
  validates :words, length: { in: 1..150 }

end
