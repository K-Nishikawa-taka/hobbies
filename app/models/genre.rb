class Genre < ApplicationRecord

  has_many :rooms, dependent: :destroy
  has_many :favorite_genres, dependent: :destroy

  validates :name, presence: true
  
  def favorited_by?(user)
    favorite_genres.where(user_id: user.id).exists?
  end

end
