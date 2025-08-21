class Chat < ApplicationRecord
  acts_as_chat

  belongs_to :user
  belongs_to :company
  has_many :messages, dependent: :destroy
end
