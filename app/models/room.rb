class Room < ApplicationRecord

  belongs_to :genre
  has_many :messages, dependent: :destroy

  validates :name, presence: true

end
