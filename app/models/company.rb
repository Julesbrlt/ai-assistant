class Company < ApplicationRecord
  has_many :chats
  validates :name, presence: true
  validates :activity, presence: true
  validates :description, presence: true
  validates :objectives, presence: true
end
