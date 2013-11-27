class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :email
      t.string :last_4_digits
      t.string :stripe_customer_token
      t.belongs_to :company

      t.timestamps
    end
    add_index :subscriptions, :company_id
  end
end
