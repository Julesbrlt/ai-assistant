class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :activity
      t.text :description
      t.text :objectives
      t.string :location
      t.string :company_size

      t.timestamps
    end
  end
end
