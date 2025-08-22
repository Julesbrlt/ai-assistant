class RemoveRef < ActiveRecord::Migration[7.1]
  def change
    remove_reference :messages, :tool_call, index: true, foreign_key: true
  end
end
