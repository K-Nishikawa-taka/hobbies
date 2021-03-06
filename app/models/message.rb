class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room, touch: true
  has_many :comments, dependent: :destroy
  has_many :favorite_messages, dependent: :destroy
  attachment :post_image

  validates :words, {presence: true, length: { maximum: 150 }}
  
  def favorited_by?(user)
    favorite_messages.where(user_id: user.id).exists?
  end
  
end
