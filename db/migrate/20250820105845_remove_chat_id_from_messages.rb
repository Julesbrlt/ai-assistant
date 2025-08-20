class RemoveChatIdFromMessages < ActiveRecord::Migration[7.1]
  def change
    remove_reference :messages, :chat, foreign_key: true, index: false
  end
end
