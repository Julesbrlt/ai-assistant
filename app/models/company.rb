class Company < ApplicationRecord
  belongs_to :user
  # has_many :chats
  has_many :messages, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 100 }
  validates :objectives, presence: true, length: {minimum: 100 }
  validates :location, presence: true
  validates :size, presence: true
end
