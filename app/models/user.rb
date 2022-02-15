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
  
  #フォロー用
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed 

  validates :name, presence: true
  validates :name, length: { in: 1..15 }
  validates :personal_id, presence: true
  validates :personal_id, length: { in: 1..15 }
  validates :personal_id, uniqueness: true
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

end
