class Company < ApplicationRecord
  belongs_to :user
  # has_many :chats
  has_many :messages
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :objectives, presence: true
end
