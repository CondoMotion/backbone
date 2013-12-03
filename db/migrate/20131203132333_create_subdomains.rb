class CreateSubdomains < ActiveRecord::Migration
  def change
    create_table :subdomains do |t|
      t.string :name
      t.references :subdomainable, polymorphic: true

      t.timestamps
    end
  end
end
