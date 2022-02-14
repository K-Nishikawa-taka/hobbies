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

  validates :name, presence: true
  validates :name, length: { in: 1..15 }
  validates :personal_id, presence: true
  validates :personal_id, length: { in: 1..15 }
  validates :personal_id, uniqueness: true
  validates :introduction, length: { maximum: 150 }
  validates :email, presence: true
  validates :email, uniqueness: true

end
