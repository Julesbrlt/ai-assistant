class RemoveThingsInChats < ActiveRecord::Migration[7.1]
  def change
    remove_reference :chats, :company, foreign_key: true, index: false
    remove_reference :chats, :user, foreign_key: true, index: false
  end
end
