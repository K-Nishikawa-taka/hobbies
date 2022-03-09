class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :message
  attachment :post_image

  validates :words, {presence: true, length: {maximum: 150}}
  
end
