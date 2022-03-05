class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_genres, dependent: :destroy
  has_many :favorite_rooms, dependent: :destroy
  has_many :favorite_messages, dependent: :destroy
  attachment :icon_image

  # フォロー用
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed

  #通知用
  #自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  #相手からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :name, presence: true
  validates :name, length: { in: 1..15 }
  validates :personal_code, presence: true
  validates :personal_code, length: { in: 1..15 }
  validates :personal_code, format: { with: /\A[a-z0-9]+\z/ }
  validates :personal_code, uniqueness: true
  validates :introduction, length: { maximum: 150 }
  validates :email, presence: true
  validates :email, uniqueness: true

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
  
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # is_deletedがfalseの時にtrueを返す
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
