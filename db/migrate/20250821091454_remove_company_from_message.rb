class RemoveCompanyFromMessage < ActiveRecord::Migration[7.1]
  def change
    remove_reference :messages, :company, foreign_key: true, index: false
  end
end
