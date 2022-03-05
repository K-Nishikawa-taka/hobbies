class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :message
  attachment :post_image

  validates :words, presence: true
  validates :words, length: { in: 1..150 }
end
