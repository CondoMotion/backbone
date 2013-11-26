class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :subdomain
      t.integer :owner_id
      t.string :phone
      t.string :website
      t.string :logo

      t.timestamps
    end
  end
end
