class Message < ApplicationRecord
  acts_as_message

  belongs_to :chat
  validates :content, presence: true
  validates :role, presence: true
  validates :chat, presence: true
end
