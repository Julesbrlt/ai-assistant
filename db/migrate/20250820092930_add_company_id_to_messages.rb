class AddCompanyIdToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :company, foreign_key: true
  end
end
