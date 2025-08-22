class Company < ApplicationRecord
  belongs_to :user
  has_many :chats, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :objectives, presence: true
  validates :location, presence: true
  validates :size, presence: true
end
