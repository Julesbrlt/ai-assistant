class DropCompanyIdToMessages < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :company_id
  end
end
