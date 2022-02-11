class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true       
  validates :name, length: { in: 1..15 }
  validates :personal_id, presence: true
  validates :personal_id, length: { in: 1..15 }
  validates :personal_id, uniqueness: true
  validates :introduction, length: { maximum: 150 }
  validates :email, presence: true
  validates :email, uniqueness: true
  attachment :icon_image
         
end
