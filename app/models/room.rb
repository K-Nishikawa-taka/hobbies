class Room < ApplicationRecord
  belongs_to :genre, touch: true
  has_many :messages, dependent: :destroy
  has_many :favorite_rooms, dependent: :destroy

  validates :name, {presence: true, length: {maximum: 15}}

  def favorited_by?(user)
    favorite_rooms.where(user_id: user.id).exists?
  end

  def self.looks(key_word)
    @rooms = Room.where('name LIKE ?', "%#{key_word}%")
  end
  
end
