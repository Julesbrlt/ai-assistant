class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :activity
      t.text :description
      t.string :objectives
      t.string :location
      t.string :size
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
