class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room, touch: true
  has_many :comments, dependent: :destroy
  has_many :favorite_messages, dependent: :destroy
  has_many :notifications, dependent: :destroy
  attachment :post_image

  validates :words, presence: true
  validates :words, length: { maximum: 150 }

  def favorited_by?(user)
    favorite_messages.where(user_id: user.id).exists?
  end
  
  #通知作成メソッド
  def create_notification_favorite(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(['visitor_id = ? and visited_id = ? and message_id = ? and action = ?', current_user.id, user_id, id, 'Favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        message_id: id,
        visited_id: user_id,
        action: 'like'
      )
            # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
end
