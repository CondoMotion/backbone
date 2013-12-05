class AddCompanyIdToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :company_id, :integer
    add_index :properties, :company_id
  end
end
