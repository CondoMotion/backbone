class RemoveSubdomainFromProperties < ActiveRecord::Migration
  def up
    remove_column :properties, :subdomain
  end

  def down
    add_column :properties, :subdomain, :string
  end
end
