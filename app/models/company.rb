class Company < ApplicationRecord
  belongs_to :user
  has_many :chats
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :objectives, presence: true
end
